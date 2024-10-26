{ config, lib, pkgs, ... }:

{
imports = 
  [ ./hardware-configuration.nix ];

# OS CONFIGURATION
## Use the systemd-boot EFI bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi .canToughEfiVariables = true;

## Packages
environment.systemPackages = with pkgs = [
  git
  nginx
  vim
  wget
];

## Set your time zone
time.timeZone = "America/Chicago";

# SERVICES
services.nginx = {
  enable = true;
  virtualHosts."example.com" = {
    root = "/var/www/example/";
    serverName = "vm1";
    # enableACME = true;
  }
};

# Certs
## security.acme.defaults.email = "webmaster@example.com";
## security.acme.acceptTerms = true;

# NETWORKING
networking.hostName = "vm2";
networking.networkmanager.enable = true;
## Firewall
networking.firewall.enable = true;
networking.firewall.allowedTCPPorts = [80 443];

# USER ADMINISTRATION
users.users.dustin = {
  isNormalUser = true;
  extraGroups = [ "wheel" ];
  packages = with pkgs [
    neovim
    ranger
    firefox
    tree
  ];
};

# DO NOT TOUCH
system.stateVersion = "24.05"
};
