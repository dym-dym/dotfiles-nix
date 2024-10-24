{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        alignment="center"; 
        corner_radius=8;
        format="<b>%s</b>\n%b";
        frame_width=3;
      };
 
      urgency_critical = {
        background="#1E1E28";
        foreground="#F5E0DC";
        frame_color="#F28FAD";
      };
        
      urgency_low = {
        background="#1E1E28";
        foreground="#F5E0DC";
        frame_color="#F8BD96";
      };
        
      urgency_normal = {
        background="#1E1E28";
        foreground="#C9CBFF";
        frame_color="#B5E8E0";
      };
    };
  };
}
