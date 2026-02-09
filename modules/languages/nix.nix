{ pkgs, ... }: {
  config.specs.nix-lang = {
    after = [ "general" ]; # Ensure it loads after core logic
    lazy = true;
    # Usually, we trigger language plugins on FileType
    # You'd handle the 'event' or 'ft' in your lua/module config
    data = with pkgs.vimPlugins; [
      # specific nix plugins if any
    ];
    extraPackages = with pkgs; [
      nixd # LSP
      nixfmt-rfc-style # Formatter
    ];
  };
}
