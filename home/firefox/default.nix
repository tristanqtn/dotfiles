{ username, firefox-addons, pkgs, ... }:

let
  firefox-addons-allowUnfree = pkgs.callPackage firefox-addons { };
in
{
  ########################################
  # Firefox
  ########################################
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      
      ########################################
      # Configuration
      ########################################
      settings = {
        # Startup
        "browser.startup.page" = 1;
        "browser.startup.homepage" = "https://www.google.com/";
        
        # Enable custom CSS
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        
        # File picker
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        
        # Smooth scrolling
        "general.smoothScroll" = true;
        "general.smoothScroll.msdPhysics.enabled" = true;
        
        # Hardware acceleration
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        
        # Performance
        "browser.cache.disk.enable" = true;
        "browser.cache.memory.enable" = true;
        "browser.sessionhistory.max_total_viewers" = 4;
        
        # UI Density (compact mode)
        "browser.uidensity" = 1; # 0=normal, 1=compact, 2=touch
        
        # Font rendering
        "gfx.font_rendering.cleartype_params.rendering_mode" = 5;
        "gfx.font_rendering.cleartype_params.cleartype_level" = 100;
        
        # Tab bar
        "browser.tabs.tabMinWidth" = 100;
        "browser.tabs.drawInTitlebar" = true;
        
        # Animations
        "ui.prefersReducedMotion" = 0; # Enable animations
        
        # Privacy
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        
        # Downloads
        "browser.download.useDownloadDir" = true;
        "browser.download.autohideButton" = false;
        
        # New tab page
        "browser.newtabpage.activity-stream.feeds.topsites" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = true;
        
        # Force dark theme
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.dark-private-windows" = true;
      };
      
      ########################################
      # Style
      ########################################
      # Custom CSS for Firefox UI (userChrome.css) - Dracula Theme
      userChrome = builtins.readFile ./userChrome.css; 
      # Custom CSS for web content (userContent.css) - Dracula Theme
      userContent = builtins.readFile ./userChrome.css; 
      
      ########################################
      # Extensions
      ########################################
      extensions = {
        force = true;
        packages = with firefox-addons-allowUnfree; [
          ublock-origin
          darkreader
          privacy-badger
          onepassword-password-manager
        ];
      };

      ########################################
      # Search
      ########################################
      search = {
        force = true;
        default = "google";
        engines = {
          ddg.metaData.hidden = true;
          bing.metaData.hidden = true;
          qwant.metaData.hidden = true;
          wikipedia.metaData.hidden = true;
          perplexity.metaData.hidden = true;

          nix-packages = {
            name = "Nix Packages";
            urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                    { name = "type"; value = "packages"; }
                    { name = "channel"; value = "unstable"; }
                    { name = "query"; value = "{searchTerms}"; }
                ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          nixos-options = {
            name = "Nixos Options";
            urls = [{
                template = "https://search.nixos.org/options";
                params = [
                    { name = "type"; value = "options"; }
                    { name = "channel"; value = "unstable"; }
                    { name = "query"; value = "{searchTerms}"; }
                ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };

          youtube = {
              name = "YouTube";
              urls = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
              icon = "https://www.youtube.com/favicon.ico";
              definedAliases = [ "@yt" ];
          };

          home-manager-options = {
              name = "Home Manager Options";
              urls = [{ 
                  template = "https://home-manager-options.extranix.com/"; 
                  params = [
                      { name = "release"; value = "master"; }
                      { name = "query"; value = "{searchTerms}"; }
                  ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@hm" ];
          };
        };
      };

      ########################################
      # Bookmarks
      ########################################
      bookmarks = {
        force = true;
        settings = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "Nix";
                bookmarks = [
                  {
                    name = "Home Manager Search";
                    url  = "https://home-manager-options.extranix.com/?query=&release=master";
                  }
                  {
                    name = "Packages Search";
                    url = "https://search.nixos.org/packages";
                  }
                ];
              }
              {
                name = "Mail";
                bookmarks = [
                  {
                    name = "Google Mail";
                    url = "https://mail.google.com/mail/u/0/#inbox";
                  }
                  {
                    name = "Proton Mail";
                    url = "https://account.proton.me/fr/mail";
                  }
                ];
              }
              {
                name = "Hacking";
                bookmarks = [
                  {
                    name = "The Hacker Recipes";
                    url = "https://www.thehacker.recipes/";
                  }
                  {
                    name = "The Hacker Tools";
                    url = "https://tools.thehacker.recipes/";
                  }
                  {
                    name = "The Red-Book";
                    url = "https://red.infiltr8.io/";
                  }
                  {
                    name = "GitBook";
                    url = "https://app.gitbook.com/o/TrvQMF0viBeMKtoH0FuF/home";
                  }
                  {
                    name = "HackTricks";
                    url = "https://book.hacktricks.wiki/en/index.html";
                  }
                  {
                    name = "Red Team Notes";
                    url = "https://www.ired.team/";
                  }
                  {
                    name = "Internal All The Things";
                    url = "https://swisskyrepo.github.io/InternalAllTheThings/";
                  }
                  {
                    name = "RootMe";
                    url = "https://www.root-me.org/";
                  }
                  {
                    name = "Exegol";
                    bookmarks = [
                      {
                        name = "Exegol Dashboard";
                        url = "https://dashboard.exegol.com/auth";
                      }
                      {
                        name = "Exegol Docs";
                        url = "https://docs.exegol.com/first-install";
                      }
                    ];
                  }
                  {
                    name = "HackTheBox";
                    bookmarks = [
                      {
                        name = "HTB Labs";
                        url = "https://app.hackthebox.com/home";
                      }
                      {
                        name = "HTB Academy";
                        url = "https://academy.hackthebox.com/dashboard";
                      }
                    ];
                  }
                  {
                    name = "Tools";
                    bookmarks = [
                      {
                        name = "ngrok";
                        url = "https://dashboard.ngrok.com/login";
                      }
                      {
                        name = "Webhook.site";
                        url = "https://webhook.site/#!/view/84c10da5-3e92-4414-aed6-8a265a98146f";
                      }
                      {
                        name = "OAuth Tools";
                        url = "https://oauth.tools/?ref=jwt_tools";
                      }
                      {
                        name = "CyberChef";
                        url = "https://gchq.github.io/CyberChef/";
                      }
                    ];
                  }
                  {
                    name = "Dev";
                    bookmarks = [
                      {
                        name = "ChatGPT";
                        url = "https://chatgpt.com/";
                      }
                      {
                        name = "GitHub";
                        url = "https://github.com/";
                      }
                      {
                        name = "Chocolatey";
                        url = "https://community.chocolatey.org/packages?q=";
                      }
                      {
                        name = "Jam Dev Tools";
                        url = "https://jam.dev/utilities";
                      }
                    ];
                  }
                ];
              }
              {
                name = "Pro";
                bookmarks = [
                  {
                    name = "MyPeopleDoc";
                    url = "https://www.mypeopledoc.com/#/login";
                  }
                  {
                    name = "eDocPerso";
                    url = "https://edocperso.fr/en/login";
                  }
                  {
                    name = "LinkedIn";
                    url = "https://www.linkedin.com/feed/?trk=guest_homepage-basic_nav-header-signin";
                  }
                  {
                    name = "Digiposte";
                    url = "https://secure.digiposte.fr/home";
                  }
                  {
                    name = "Génération";
                    url = "https://assure.generation.fr/adherent";
                  }
                ];
              }
              {
                name = "Video";
                bookmarks = [
                  {
                    name = "Canal";
                    url = "https://www.canalplus.com/";
                  }
                  {
                    name = "Twitch";
                    url = "https://www.twitch.tv/directory";
                  }
                  {
                    name = "YouTube";
                    url = "https://www.youtube.com/";
                  }
                  {
                    name = "France TV";
                    url = "https://www.france.tv/";
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}