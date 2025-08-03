{
  boot = {
    loader = {
      grub.enable = false;
	  systemd-boot.enable = true;
	  efi.canTouchEfiVariables = true;
    };

	initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
	  kernelModules = [ ];
	  luks.devices."luks-79e133f6-833a-4554-8431-e5c1c3b88720".device =
	    "/dev/disk/by-uuid/79e133f6-833a-4554-8431-e5c1c3b88720";
	  systemd.enable = true;
	};

	extraModulePackages = [ ];
	kernelModules = [ "kvm-intel" ];
  };

  #boot.loader.grub.enable = false;

  #boot.loader.systemd-boot.enable = true;
  #boot.initrd.systemd.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  #boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
  #boot.initrd.kernelModules = [ ];
  #boot.kernelModules = [ "kvm-intel" ];
  #boot.extraModulePackages = [ ];
  #boot.initrd.luks.devices."luks-79e133f6-833a-4554-8431-e5c1c3b88720".device = "/dev/disk/by-uuid/79e133f6-833a-4554-8431-e5c1c3b88720";
}
