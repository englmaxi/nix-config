{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop = {
      enable = true;
      package = pkgs.vesktop.overrideAttrs (finalAttrs: previousAttrs: {
        desktopItems = let
          discordIcon = "${pkgs.discord}/share/icons/hicolor/256x256/apps/discord.png";
        in [
          ((builtins.elemAt previousAttrs.desktopItems 0).override {icon = discordIcon;})
        ];
      });
    };
    config = {
      frameless = false;
      enabledThemes = [
        "stylix.theme.css"
      ];
      plugins = {
        hideAttachments.enable = true;
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
        };
        alwaysTrust.enable = true;
        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = true;
        };
        betterGifPicker.enable = true;
        betterNotesBox.enable = true;
        betterRoleDot.enable = true;
        betterUploadButton.enable = true;
        callTimer.enable = true;
        clearURLs.enable = true;
        crashHandler.enable = true;
        dearrow.enable = true;
        fullSearchContext.enable = true;
        fixCodeblockGap.enable = true;
        gifPaste.enable = true;
        imageZoom.enable = true;
        loadingQuotes.enable = true;
        memberCount.enable = true;
        messageClickActions.enable = true;
        messageLogger = {
          enable = true;
          deleteStyle = "text";
          logDeletes = true;
          logEdits = true;
          ignoreSelf = true;
        };
        noDevtoolsWarning.enable = true;
        noF1.enable = true;
        pictureInPicture.enable = true;
        previewMessage.enable = true;
        relationshipNotifier.enable = true;
        sendTimestamps.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        silentTyping.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        unsuppressEmbeds.enable = true;
        userVoiceShow.enable = true;
        viewIcons.enable = true;
        volumeBooster.enable = true;
        webKeybinds.enable = true;
        whoReacted.enable = true;
      };
    };
  };

  home =
    lib.optionalAttrs (builtins.hasAttr "persistence" config.home)
    {
      persistence = {
        "/persist/${config.home.homeDirectory}".directories = [
          ".config/vesktop/sessionData"
          ".config/vesktop/state.json"
        ];
      };
    };
}
