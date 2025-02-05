{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./pkgs.nix
  ];

  boot = {
    kernelParams = [ "mem_sleep_default=s2idle" "intel_pstate=active" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };

    apple.touchBar = {
      enable = true;
      settings = {
        MediaLayerDefault = false;
        ShowButtonOutlines = true;
        EnablePixelShift = true;
      };
    };

    # Apple Wifi & BT firmware
    firmware = [
      (pkgs.stdenvNoCC.mkDerivation (final: {
        name = "brcm-firmware";
        src = ./firmware/brcm;
        installPhase = ''
          mkdir -p $out/lib/firmware/brcm
          cp ${final.src}/* "$out/lib/firmware/brcm"
        '';
      }))
    ];

  };

  networking.hostName = "hon";
  time.timeZone = "Europe/Budapest";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver.enable = true;
    libinput.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  users.users.fev = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}

