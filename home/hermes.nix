{ config, lib, osConfig, secrets, ... }:

{
  config = lib.mkIf osConfig.localLLM.enable {
    programs.hermes-agent = {
      enable = true;
      desktop.enable = true;
    };
    
    home.sessionVariables.HERMES_HOME =
      "${config.home.homeDirectory}/.hermes";

    services.hermes-agent = {
      enable = true;

      hermesHome = "${config.home.homeDirectory}/.hermes";
      settings = {
        model = {
          default = "qwen3.5:4b";
          provider = "custom";
          base_url = "http://127.0.0.1:11434/v1";
          context_length = 65536;
        };
      };


      gateway.enable = true;

      environment = {
        TELEGRAM_BOT_TOKEN = secrets.hermes.telegram.bot_token;
        TELEGRAM_ALLOWED_USERS = secrets.hermes.telegram.user_id;
        TELEGRAM_HOME_CHANNEL = secrets.hermes.telegram.user_id;
      };


    };
  };
}
