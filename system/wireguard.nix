{ config, pkgs, ...}:
{

  # Enable wireguard VPN
  networking.wireguard.enable = true;

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wg-quick.interfaces = {
    wg_home = {
      address = [ "10.192.1.2/24" ];
      dns = [ "10.192.1.1" "9.9.9.9" ];
      privateKeyFile = "/home/dymdym/.ssh/privatekey_dymwork";

      peers = [
        {
          publicKey = "hN8vhr7WahPF+VsrIlEXAsB+QD3JXQmu1IJOnB6MhyQ=";
          presharedKeyFile = "/home/dymdym/.ssh/presharedkey_dymwork";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "vpn.dylanbettendroffer.fr:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
