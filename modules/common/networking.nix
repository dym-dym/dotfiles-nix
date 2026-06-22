{config, ...}: {
  ## == Network ==

  networking = {
    hostName = config.hostname;

    # Enable networking
    networkmanager.enable = true;

    # Setup DNS
    nameservers = ["9.9.9.9"];
    firewall.allowedTCPPorts = [8384];

    # networking.wireless.enable = config.wireless.enable;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
}
