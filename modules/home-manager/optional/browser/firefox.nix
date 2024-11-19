{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = {
        "browser.startup.homepage" = "https://searx.aicampground.com";
        "browser.search.defaultenginename" = "Searx";
        "browser.search.order.1" = "Searx";
      };
      search = {
        force = true;
        default = "Searx";
        order = ["Searx" "Google"];
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "NixOS Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nixos"];
          };
          "Home-Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "release";
                    value = "master";
                  }
                ];
              }
            ];
            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@hm"];
          };
          "NixOS Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };
          "Searx" = {
            urls = [{template = "https://searx.aicampground.com/?q={searchTerms}";}];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@searx"];
          };
          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g";
        };
      };

      settings = {
        "app.normandy.first_run" = false;
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "signon.firefoxRelay.feature" = false;
        "layout.css.color-mix.enabled" = true;
        "toolkit.legacyUserProfileCustomiations.stylesheets" = true;
        "browser.tabs.firefox-view" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "dom.security.https_only_mode" = true;
        "extensions.autoDisableScopes" = 0;
      };
      extensions = with pkgs.inputs.firefox-addons; [
        ublock-origin
        bitwarden
        clearurls
        sponsorblock
        return-youtube-dislikes
        translate-web-pages
      ];
      userContent = ''
        @-moz-document url("about:newtab"), url("about:home") {
            body {
                background-color: #${config.lib.stylix.colors.base00} !important;
            }
            .search-handoff-button, .tile {
                background-color: #${config.lib.stylix.colors.base01}  !important;
                backdrop-filter: blur(10px);
            }
        }
      '';
      userChrome = ''
        #main-window {
            background: transparent !important;
            -moz-appearance: transparent !important;
        }

        #urlbar:not([focused]) > #urlbar-background  {
            border: none !important;
            box-shadow: none !important;
            opacity: 0.3;
        }


        #urlbar:not([focused])  {
            text-align: center;
        }

        toolbar#nav-bar {
            box-shadow: none !important;
            border-top: none !important;
            background: transparent !important;
        }

        .tab-background[selected] {
            background: #${config.lib.stylix.colors.base0E} !important;
            opacity: 0.3;
        }

        .tab-content::before{
            content: "";
            display: -moz-box;
            -moz-box-flex: 1
        }

        #tabbrowser-tabs{
          border-inline-start: none !important;
        }


        .tab-close-button {
            opacity: 0.5 !important;
        }

      '';
    };
  };

  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist/${config.home.homeDirectory}".directories = [".mozilla/firefox"];
      };
    };
}
