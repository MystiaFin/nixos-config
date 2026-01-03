{ config, pkgs, hw_file, ... }:

{
  security.sudo.extraRules = [
    {
      users = [ "mystiafin" ];
      commands = [
        { command = "/run/current-system/sw/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];

  systemd.services.nixos-saturday-update = {
    description = "Update Nix flake, rebuild system, and push changes";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      User = "mystiafin";
    };

    path = with pkgs; [ git openssh nixos-rebuild nix ];

    script = ''
      FLAKE_DIR="/home/mystiafin/nixos-config" 
      
      HOST_NAME="${hw_file}"
      if [ ! -d "$FLAKE_DIR" ]; then
        echo "Error: Flake directory $FLAKE_DIR does not exist."
        exit 1
      fi

      cd "$FLAKE_DIR" || exit 1

      echo "--- 1. Updating Flake Inputs ---"
      nix flake update

      echo "--- 2. Rebuilding System for $HOST_NAME ---"
      # We use sudo here, which is allowed without password via the rule above
      sudo nixos-rebuild switch --flake .#"$HOST_NAME"

      echo "--- 3. Git Operations ---"
      if [[ -n $(git status --porcelain flake.lock) ]]; then
        echo "Changes detected in flake.lock. Committing..."
        git add flake.lock
        git commit -m "chore: automatic saturday flake update"
        
        echo "Pushing to remote..."
        git push
      else
        echo "No changes in flake.lock, skipping git push."
      fi
    '';
  };

  systemd.timers.nixos-saturday-update = {
    wantedBy = [ "timers.target" ];
    partOf = [ "nixos-saturday-update.service" ];
    timerConfig = {
      OnCalendar = "Sat *-*-* 00:00:00";
      Persistent = true;
      RandomizedDelaySec = "5m";
    };
  };
}
