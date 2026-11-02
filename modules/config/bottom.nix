{ config, pkgs, ... }:

{
  programs.bottom = {
    enable = true;
    settings = {
      # one row per program name instead of one per process
      flags.group_processes = true;

      # MB is readable at a glance, a percent of total ram isn't
      flags.process_memory_as_value = true;

      # terminal slots instead of hex so it follows amane's palette, magenta sits closest to the accent
      styles = {
        tables.headers = {
          color = "magenta";
          bold = true;
        };
        widgets = {
          selected_border_color = "magenta";
          selected_text = {
            color = "black";
            bg_color = "magenta";
          };
        };
      };

      # the process list is the point, cpu and memory stay as a small strip on top
      row = [
        {
          ratio = 1;
          child = [
            {
              type = "cpu";
              ratio = 2;
            }
            {
              type = "temp";
              ratio = 1;
            }
            {
              type = "mem";
              ratio = 2;
            }
          ];
        }
        {
          ratio = 3;
          child = [
            {
              type = "proc";
              default = true;
            }
          ];
        }
      ];
    };
  };
}
