{ pkgs, lib, ... }:
let
  marketplaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "chatgpt";
      publisher = "openai";
      version = "26.5721.30844";
      sha256 = pkgs.lib.fakeHash;
    }
    {
      name = "geminicodeassist";
      publisher = "Google";
      version = "2.75.0";
      sha256 = "sha256-nydm7PTcUi9XSWXrzWNttHeNFBulFRV87C5/yuCtf9k=";
    }
  ];
in
{
  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = false;
    profiles.default = {
      userSettings = {
        "workbench.colorTheme" = lib.mkForce "Default Dark Modern";
        "markdown-preview-enhanced.chromePath" =
          lib.mkForce "/run/current-system/sw/bin/google-chrome-stable";

        "editor.fontSize" = lib.mkForce 16;
        "terminal.integrated.fontSize" = lib.mkForce 16;

        "geminicodeassist.project" = lib.mkForce "project-7555ff4f-a441-4630-934";
        "geminicodeassist.agentYoloMode" = true;
      };

      extensions =
        (with pkgs.vscode-extensions; [
          bbenoist.nix
          jeff-hykin.better-nix-syntax
          ms-vscode.cpptools-extension-pack
          vscodevim.vim
          mads-hartmann.bash-ide-vscode
          tamasfe.even-better-toml
          zainchen.json
        ])
        ++ marketplaceExtensions;
    };
  };
}
