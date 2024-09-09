{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../../modules/nixos/configuration.nix
    ./../../modules/nixos/nvidia.nix
  ];
}
