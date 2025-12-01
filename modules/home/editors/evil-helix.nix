{ pkgs, lib, ... }:
let
  enableEvilHelix = true; 
in
{
  # 1. Die Language Server installieren (das bleibt fast gleich)
  home.packages = with pkgs; lib.mkIf enableEvilHelix [
    # Helix selbst muss hier nicht stehen, das macht programs.helix weiter unten
    cmake-language-server
    jsonnet-language-server
    luaformatter
    lua-language-server
    marksman
    taplo
    nil
    jq-lsp
    vscode-langservers-extracted
    bash-language-server
    awk-language-server
    vscode-extensions.llvm-vs-code-extensions.vscode-clangd
    clang-tools
    docker-compose-language-service
    docker-compose
    docker-language-server
    typescript-language-server
  ];


  programs.helix = {
    enable = enableEvilHelix;
    
    settings = {
      # theme = "catppuccin_mocha"; # Stylix kümmert sich jetzt darum

      editor = {
        # evil = true;  <-- DIESE ZEILE WAR DER FEHLER (GELÖSCHT)
        
        end-of-line-diagnostics = "hint";
        auto-pairs = true;
        mouse = true;
        middle-click-paste = true;
        shell = ["zsh" "-c"];
        line-number = "absolute";
        auto-completion = true;
        path-completion = true;
        auto-info = true;
        color-modes = true;
        popup-border = "all";
        
        # clipboard-provider = "wayland"; 
        
        indent-heuristic = "hybrid";
        
        statusline = {
          left = ["mode" "spinner"];
          center = ["file-absolute-path" "total-line-numbers" "read-only-indicator" "file-modification-indicator"];
          right = ["diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type"];
          separator = "│";
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        lsp = {
          enable = true;
          display-messages = true;
          display-progress-messages = true;
        };
        
        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "hint";
        };
      };
    };

    languages = {
      language-server = {
        nil = { command = "nil"; };
        lua = { command = "lua-language-server"; };
        json = { command = "vscode-json-languageserver"; };
        markdown = { command = "marksman"; };
      };
    };
  };
}
