{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nur.modules.homeManager.default
  ];

  stylix.targets.firefox = {
    profileNames = ["default"];
    colorTheme.enable = true;
  };

  programs.firefox = let
    c = config.lib.stylix.colors;
  in {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "browser.startup.homepage" = "https://www.startpage.com";
        "browser.search.defaultenginename" = "Startpage";
        "browser.search.order.1" = "Startpage";
      };
      search = {
        force = true;
        default = "Startpage";
        order = ["Startpage" "Searx" "google"];
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
            icon = "https://nixos.wiki/favicon.png";
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
            icon = "https://nixos.wiki/favicon.png";
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
            icon = "https://nixos.wiki/favicon.png";
            definedAliases = ["@hm"];
          };
          "NixOS Wiki" = {
            urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };
          "Searx" = {
            urls = [{template = "https://searx.aicampground.com/?q={searchTerms}";}];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@searx"];
          };
          "Startpage" = {
            urls = [
              {
                template = "https://www.startpage.com/do/search";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://cdn.startpage.com/sp/cdn/favicons/mobile/apple-icon-180x180.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@sp"];
          };
          "bing".metaData.hidden = true;
          "google".metaData.alias = "@g";
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
      extensions.force = true;
      extensions.packages = builtins.attrValues {
        inherit
          (pkgs.nur.repos.rycee.firefox-addons)
          ublock-origin
          bitwarden
          clearurls
          enhancer-for-youtube
          sponsorblock
          return-youtube-dislikes
          translate-web-pages
          ;
      };
      # userContent = ''
      #   @-moz-document url("about:newtab"), url("about:home") {
      #       body {
      #           background-color: #${c.base00} !important;
      #       }
      #       .search-handoff-button, .tile {
      #           background-color: #${c.base01}  !important;
      #           backdrop-filter: blur(10px);
      #       }
      #   }
      # '';
      # userChrome = ''
      #   #main-window {
      #       background: transparent !important;
      #       -moz-appearance: transparent !important;
      #   }
      #
      #   #urlbar:not([focused]) > #urlbar-background  {
      #       border: none !important;
      #       box-shadow: none !important;
      #       opacity: 0.3;
      #   }
      #
      #
      #   #urlbar:not([focused])  {
      #       text-align: center;
      #   }
      #
      #   toolbar#nav-bar {
      #       box-shadow: none !important;
      #       border-top: none !important;
      #       background: transparent !important;
      #   }
      #
      #   .tab-background[selected] {
      #       background: #${c.base0E} !important;
      #       opacity: 0.3;
      #   }
      #
      #   .tab-content::before{
      #       content: "";
      #       display: -moz-box;
      #       -moz-box-flex: 1
      #   }
      #
      #   #tabbrowser-tabs{
      #     border-inline-start: none !important;
      #   }
      #
      #
      #   .tab-close-button {
      #       opacity: 0.5 !important;
      #   }
      #
      # '';
    };
  };

  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist".directories = [".mozilla/firefox"];
      };
    };
}
