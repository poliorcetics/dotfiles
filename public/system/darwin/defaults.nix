# Configure macOS System Settings
#
# See also <https://macos-defaults.com>
{ userDetails, ... }:
{
  system.defaults = {
    # Firewall configuration
    # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/defaults/alf.nix>
    alf = {
      globalstate = 1;
      stealthenabled = 1;
    };

    # Control center
    # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/defaults/controlcenter.nix>
    controlcenter = {
      BatteryShowPercentage = true;
      Sound = false;
      Bluetooth = true;
    };

    # Dock
    # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/defaults/dock.nix>
    #
    #     defaults read com.apple.dock
    dock = {
      persistent-apps = [
        "/System/Applications/System Settings.app"
        "/Applications/Firefox.app"
        "/System/Applications/Mail.app"
        "/Applications/kitty.app"
        "/Applications/Transmission.app"
      ];
      persistent-others = [
        "${userDetails.home}/Downloads"
      ];
    };

    # Finder
    # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/defaults/finder.nix>
    #
    #     defaults read com.apple.finder
    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
    };

    # Login windows
    # <https://github.com/nix-darwin/nix-darwin/blob/nix-darwin-25.05/modules/system/defaults/loginwindow.nix>
    #
    #     defaults read com.apple.finder
    loginwindow.GuestEnabled = false;

    # Find all domains (nushell):
    #
    #     defaults domains | split row ', ' | sort | save -f /tmp/defaults.txt
    CustomSystemPreferences = {
      ".GlobalPreferences_m" = {
        AppleLanguages = [
          "en-US"
          "fr-FR"
        ];
        AppleLocale = "en_US@rg=frzzzz";
      };

      "com.apple.AppleMultitouchTrackpad" = {
        ActuateDetents = 0;
        Clicking = 1;
        DragLock = 0;
        Dragging = 0;
        FirstClickThreshold = 1;
        ForceSuppressed = 1;
        SecondClickThreshold = 1;
        TrackpadCornerSecondaryClick = 0;
        TrackpadFiveFingerPinchGesture = 2;
        TrackpadFourFingerHorizSwipeGesture = 2;
        TrackpadFourFingerPinchGesture = 2;
        TrackpadFourFingerVertSwipeGesture = 2;
        TrackpadHandResting = 1;
        TrackpadHorizScroll = 1;
        TrackpadMomentumScroll = 1;
        TrackpadPinch = 1;
        TrackpadRightClick = 1;
        TrackpadRotate = 1;
        TrackpadScroll = 1;
        TrackpadThreeFingerDrag = 1;
        TrackpadThreeFingerHorizSwipeGesture = 0;
        TrackpadThreeFingerTapGesture = 2;
        TrackpadThreeFingerVertSwipeGesture = 0;
        TrackpadTwoFingerDoubleTapGesture = 1;
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
        USBMouseStopsTrackpad = 0;
      };

      "com.apple.HIToolbox" = {
        AppleEnabledInputSources = [
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 0;
            "KeyboardLayout Name" = "U.S.";
          }
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 1;
            "KeyboardLayout Name" = "French";
          }
          {
            "Bundle ID" = "com.apple.CharacterPaletteIM";
            InputSourceKind = "Non Keyboard Input Method";
          }
          {
            "Bundle ID" = "com.apple.PressAndHold";
            InputSourceKind = "Non Keyboard Input Method";
          }
        ];
        AppleFnUsageType = 2;
      };

      "com.apple.Safari" = {
        AutoOpenSafeDownloads = 0;
        DownloadsClearingPolicy = 2;
        "ExtensionsToolbarConfiguration BrowserStandaloneTabBarToolbarIdentifier-v2".OrderedToolbarItemIdentifiers =
          [
            "CombinedSidebarTabGroupToolbarIdentifier"
            "SidebarSeparatorToolbarItemIdentifier"
            "BackForwardToolbarIdentifier"
            "NSToolbarFlexibleSpaceItem"
            "InputFieldsToolbarIdentifier"
            "NSToolbarFlexibleSpaceItem"
            "ShareToolbarIdentifier"
            "NewTabToolbarIdentifier"
            "TabPickerToolbarIdentifier"
          ];
        IncludeDevelopMenu = 1;
        SearchProviderShortName = "DuckDuckGo";
        ShowFullURLInSmartSearchField = 1;
      };

      "com.apple.controlcenter" = {
        "NSStatusItem Preferred Position Bluetooth" = 329;
        "NSStatusItem Preferred Position Display" = 428;
        "NSStatusItem Preferred Position FocusModes" = 404;
        "NSStatusItem Preferred Position NowPlaying" = 443;
        "NSStatusItem Preferred Position ScreenMirroring" = 435;
        "NSStatusItem Preferred Position Sound" = 442;
        "NSStatusItem Visible AudioVideoModule" = 0;
        "NSStatusItem Visible Battery" = 1;
        "NSStatusItem Visible BentoBox" = 1;
        "NSStatusItem Visible Bluetooth" = 1;
        "NSStatusItem Visible Clock" = 1;
        "NSStatusItem Visible Display" = 0;
        "NSStatusItem Visible FaceTime" = 0;
        "NSStatusItem Visible FocusModes" = 1;
        "NSStatusItem Visible Item-0" = 0;
        "NSStatusItem Visible Item-1" = 0;
        "NSStatusItem Visible Item-10" = 0;
        "NSStatusItem Visible Item-11" = 0;
        "NSStatusItem Visible Item-2" = 0;
        "NSStatusItem Visible Item-3" = 0;
        "NSStatusItem Visible Item-4" = 0;
        "NSStatusItem Visible Item-5" = 0;
        "NSStatusItem Visible Item-6" = 0;
        "NSStatusItem Visible Item-7" = 0;
        "NSStatusItem Visible Item-8" = 0;
        "NSStatusItem Visible Item-9" = 0;
        "NSStatusItem Visible NowPlaying" = 0;
        "NSStatusItem Visible ScreenMirroring" = 0;
        "NSStatusItem Visible Sound" = 0;
        "NSStatusItem Visible WiFi" = 1;
        missionControlTooltipCount = 3;
      };

      "com.apple.dock" = {
        autohide = 1;
        autohide-delay = "0.1";
        autohide-time-modifier = "0.1";
        largesize = 36;
        loc = "en_US:FR";
        magnification = 1;
        mru-spaces = 0;
        region = "FR";
        show-recents = 0;
        showAppExposeGestureEnabled = 1;
        tilesize = 25;
        trash-full = 0;
        version = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-br-modifier = 0;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };

      "com.apple.driver.AppleBluetoothMultitouch.trackpad" = {
        Clicking = 1;
        DragLock = 0;
        Dragging = 0;
        TrackpadCornerSecondaryClick = 0;
        TrackpadFiveFingerPinchGesture = 2;
        TrackpadFourFingerHorizSwipeGesture = 2;
        TrackpadFourFingerPinchGesture = 2;
        TrackpadFourFingerVertSwipeGesture = 2;
        TrackpadHandResting = 1;
        TrackpadHorizScroll = 1;
        TrackpadMomentumScroll = 1;
        TrackpadPinch = 1;
        TrackpadRightClick = 1;
        TrackpadRotate = 1;
        TrackpadScroll = 1;
        TrackpadThreeFingerDrag = 1;
        TrackpadThreeFingerHorizSwipeGesture = 0;
        TrackpadThreeFingerTapGesture = 2;
        TrackpadThreeFingerVertSwipeGesture = 0;
        TrackpadTwoFingerDoubleTapGesture = 1;
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
        USBMouseStopsTrackpad = 0;
      };

      # TODO: com.apple.finder

      "com.apple.menuextra.clock" = {
        FlashDateSeparators = 0;
        Show24Hour = 1;
        ShowAMPM = 1;
        ShowDate = 0;
        ShowDayOfWeek = 1;
        ShowSeconds = 0;
      };

      # Used for preferences that don't have a domain
      # "NSGlobalDomain" = { };
    };
  };
}
