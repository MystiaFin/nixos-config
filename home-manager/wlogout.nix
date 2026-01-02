{ config, pkgs, ... }:

{
  xdg.configFile."wlogout/layout".text = ''
    {
        "label" : "lock",
        "action" : "loginctl lock-session",
        "text" : "Lock",
        "keybind" : "l"
    }
    {
        "label" : "logout",
        "action" : "loginctl terminate-user $USER",
        "text" : "Logout",
        "keybind" : "e"
    }
    {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
    }
    {
        "label" : "hibernate",
        "action" : "systemctl hibernate",
        "text" : "Hibernate",
        "keybind" : "h"
    }
    {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
    }
    {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
    }
  '';

  xdg.configFile."wlogout/style.css".text = ''
    * {
      background-image: none;
      font-family: "JetBrainsMono Nerd Font";
      font-size: 13px;
    }

    window {
      background-color: rgba(30, 30, 46, 0.95);
    }

    button {
      color: #cdd6f4;
      background-color: #313244;
      border: 2px solid #45475a;
      background-repeat: no-repeat;
      
      background-position: center 25px; 
      background-size: 64px;
      
      min-height: 110px;                
      min-width: 110px;                 
      
      border-radius: 12px;
      margin: 5px;
      padding: 0px; 
      transition: background-color 0.2s, border-color 0.2s; 
    }

    button:focus, button:active, button:hover {
      background-color: #45475a;
      border-color: #89b4fa;
      color: #89b4fa;
    }

    #lock {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/lock.png");
    }

    #logout {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/logout.png");
    }

    #suspend {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/suspend.png");
    }

    #hibernate {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png");
    }

    #shutdown {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png");
    }

    #reboot {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/reboot.png");
    }
  '';
}
