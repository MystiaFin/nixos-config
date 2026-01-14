{ config, pkgs, ... }:

{
  # 1. Install the package manually since the module doesn't exist
  home.packages = with pkgs; [
    blesh
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;

    # 2. Command Aliases
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
    };

    # 3. History Settings
    historyControl = [ "ignoredups" "ignorespace" ];

    # 4. Bindings, Loading ble.sh, and Theming
    initExtra = ''
      # --- LOAD BLE.SH MANUALLY ---
      # This points directly to the file in the nix store
      source ${pkgs.blesh}/share/blesh/ble.sh

      # --- History Cycling (Up/Down arrows) ---
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      
      # Optional: Ctrl+Backspace to delete words
      bind '"\C-w": backward-kill-word'

      # --- BLE.SH THEME CONFIGURATION ---
      # Check if ble.sh is actually loaded
      if [[ ''${BLE_VERSION-} ]]; then
        
        # Make autosuggestions (ghost text) subtle grey
        ble-face -s auto_complete fg=242,bg=default

        # Fix the ugly purple selection background to a dark grey
        ble-face -s region bg=238,fg=white
        ble-face -s region_match fg=blue,bold

        # Make syntax errors less jarring (red underline instead of block)
        ble-face -s syntax_error bg=none,fg=red,underline

        # Hide the status line at the bottom
        bleopt prompt_status_line=""
      fi
    '';
  };
}
