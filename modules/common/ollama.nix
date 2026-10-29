{ config, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;

    loadModels = [
      "qwen3.5:9b"
      "mistral"
      "edtorre/qwen3.5-hermes"
    ];
  };

  systemd.services.ollama.environment = {
    OLLAMA_CONTEXT_LENGTH = "65536";
  };
}
