{ config, lib, pkgs, inputs, ... }:
{
  options = {
    firefox.enable = lib.mkEnableOption "enable firefox";
  };

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;

      profiles.dymdym = {
        settings = {
          "dom.security.https_only_mode" = true;
          "browser.download.panel.shown" = true;
          "identity.fxaccounts.enabled" = false;
          "signon.rememberSignons" = false;
          "webgl.disabled" = false;
          "privacy.resistFingerprinting" = false;
        };

        # bookmarks = [
        #   {
        #     name = "";
        #     tags = [ "" ];
        #     keyword = "";
        #     url = "";
        #   }
        # ];
        #
        search.engines = {

          "SearXNG" = {
            urls = [{
              template = "";
              params = [
                {}
                {}
              ];
            }];
          };

        };
        search.force = true;

        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [

          bitwarden
          privacy-redirect
          sponsorblock
          vimium
          tabliss
          sidebery
          userchrome-toggle-extended
          firefox-color

        ];

        userChrome = ''
        /*
         * This Source Code Form is subject to the terms of the Mozilla Public
         * License, v. 2.0. If a copy of the MPL was not distributed with this
         * file, You can obtain one at https://mozilla.org/MPL/2.0/.
         */
        
        @import url("browser/main.css");
        @import url("vars.css");
        
        :root {
            @media not (-moz-bool-pref: "uc.tweak.no-panel-hint") {
                --uc-panel-hint: color-mix( in srgb, var(--toolbarbutton-icon-fill), transparent 75%);
            }
        
            --uc-bg: var(--uc-bg-opaque);
            
            --uc-bg-opaque: light-dark(rgb(239, 239, 242), rgb(27, 26, 32));
            @media (-moz-bool-pref: "uc.tweak.translucency") {
                --uc-bg: light-dark(
                    color-mix(in srgb, rgb(239, 239, 242), transparent 10%), 
                    color-mix(in srgb, rgb(27, 26, 32), transparent 10%) 
                );
            }
        
            &[lwtheme="true"] {
                --uc-bg-opaque: var(--lwt-accent-color);
                @media (-moz-bool-pref: "uc.tweak.translucency") {
                    --uc-bg: color-mix(in srgb, var(--lwt-accent-color), transparent 10%);
                }
            }
        }
        '';

        userContent = ''
        /*
         * This Source Code Form is subject to the terms of the Mozilla Public
         * License, v. 2.0. If a copy of the MPL was not distributed with this
         * file, You can obtain one at https://mozilla.org/MPL/2.0/.
         */
        
        @import url("vars.css");
        @import url("content/sidebery.css");
        @import url("content/about.css");
        
        /* pdf viewer */
        [mozdisallowselectionprint] > body {
            & #mainContainer {
                & .toolbar {
                    padding: 4px !important;
                    padding-bottom: none !important;
                    & #toolbarContainer {
                        border-radius: var(--user-radius) !important;
                        box-shadow: none !important;
                    }
                }
            }
        }
        '';

        extraConfig = ''
          // userchrome.css usercontent.css activate
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

          // Fill SVG Color
          user_pref("svg.context-properties.content.enabled", true);

          // CSS's `:has()` selector 
          user_pref("layout.css.has-selector.enabled", true);

          // Integrated calculator at urlbar
          user_pref("browser.urlbar.suggest.calculator", true);

          // Integrated unit convertor at urlbar
          user_pref("browser.urlbar.unitConversion.enabled", true);

          // Trim  URL
          user_pref("browser.urlbar.trimHttps", true);
          user_pref("browser.urlbar.trimURLs", true);

          // GTK rounded corners
          user_pref("widget.gtk.rounded-bottom-corners.enabled", true);

          // show compact mode
          user_pref("browser.compactmode.show", true);

          // fix sidebar tab drag on linux
          user_pref("widget.gtk.ignore-bogus-leave-notify", 1);

          // option for transparent tab bg (disabled to due issues on some websites)
          // user_pref("browser.tabs.allow_transparent_browser", false);

          // uidensity -> compact
          user_pref("browser.uidensity", 1);
        '';

      };
    };
  };
}
