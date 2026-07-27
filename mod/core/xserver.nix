{host, ...}: let
  variables = import ../../hosts/${host}/variables.nix;
  inherit (variables) keyboardLayout;
  keyboardOptions = variables.keyboardOptions or "grp:alt_shift_toggle";
in {
  services.xserver = {
    enable = false;
    xkb = {
      layout = "${keyboardLayout}";
      options = "${keyboardOptions}";
      variant = "";
    };
  };
}
