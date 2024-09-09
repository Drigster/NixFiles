{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../../configuration.nix
    nixos-hardware.nixosModules.framework-16-7040-amd
  ];

  boot.kernelParams = ["amdgpu.abmlevel=0"];
  services.power-profiles-daemon.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0012", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0014", ATTR{power/wakeup}="disabled", ATTR{driver/1-1.1.1.4/power/wakeup}="disabled"
  '';
}
