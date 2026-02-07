{
  osConfig ? null,
  config,
  ...
}:

{
  ########################################
  # NVF
  ########################################
  programs.nvf = {
    enable = true;
    defaultEditor = true;

    settings.vim = import ./vim-settings.nix {
      inherit osConfig config;
    };
  };
}
