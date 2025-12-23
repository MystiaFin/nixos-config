{
  programs.wofi = {
    enable = true;
    
    settings = {
      height = "40%";
      width = "40%";
      location = 2;
      yoffset = 300;
      
      mode = "run";
      matching = "fuzzy";
      insensitive = true;
      prompt = "";
      
      term = "kitty";
      hide_scroll = true;
      line_wrap = "word";
      single_click = true;
    };

    style = ''
      * {
        font-family: Inter Medium;
      }

      window {
        margin: 1px;
        border: 10px solid #7aa2f7;
        border-radius: 10px;
      }

      #input {
        margin: 5px;
        border-radius: 0px;
        border: none;
        border-bottom: 0px solid #c0caf5;
        background-color: #1d202f;
        color: #c0caf5;
      }

      #inner-box {
        margin: 5px;
        background-color: #1d202f;
      }

      #outer-box {
        margin: 3px;
        padding: 20px;
        background-color: #1d202f;
        border-radius: 10px;
      }

      #text {
        margin: 5px;
        color: #c0caf5;
      }

      #entry:selected {
        background-color: #414868;
      }

      #text:selected {
        text-decoration-color: #c0caf5;
      }
    '';
  };
}
