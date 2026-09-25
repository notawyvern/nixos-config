{ self, inputs, ... }:
{
  flake.nixosModules.hardware-laptop =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      boot.initrd.kernelModules = [ ];
      boot.extraModulePackages = [ ];
      boot.kernelModules = [ "kvm-intel" ];

      boot.initrd.luks.devices."cryptroot" = {
        device = "/dev/disk/by-partlabel/disk-main-ROOT";
        crypttabExtraOpts = [ "tpm2-device=auto" ]; # automatically unlock luks
      };

      fileSystems."/" = {
        device = "/dev/mapper/cryptroot";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-partlabel/disk-main-BOOT";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
