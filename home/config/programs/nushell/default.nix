{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    nushell.enable = lib.mkEnableOption "enable nushell";
  };

  config = lib.mkIf config.nushell.enable {
    programs = {
      nushell = {
        enable = true;
        configFile = {
          text = ''
            $env.config.edit_mode = 'vi'
          '';
        };

        extraConfig = ''
                   let carapace_completer = {|spans|
                   carapace $spans.0 nushell $spans | from json
                   }
                   $env.config = {
                    show_banner: false,
                    completions: {
                    case_sensitive: false # case-sensitive completions
                    quick: true    # set to false to prevent auto-selecting completions
                    partial: true    # set to false to prevent partial filling of the prompt
                    algorithm: "fuzzy"    # prefix or fuzzy
                    external: {
                    # set to false to prevent nushell looking into $env.PATH to find more suggestions
                        enable: true
                    # set to lower can improve completion performance at the cost of omitting some options
                        max_results: 100
                        completer: $carapace_completer # check 'carapace_completer'
                      }
                    }
                   }
                   $env.PATH = ($env.PATH |
                   split row (char esep) |
                   prepend /home/myuser/.apps |
                   append /usr/bin/env
                   )

          # alias the built-in ls command to ls-builtins
                  alias ls-builtin = ls

          # List the filenames, sizes, and modification times of items in a directory.
                  def ls [
                      --all (-a),         # Show hidden files
                      --long (-l),        # Get all available columns for each entry (slower; columns are platform-dependent)
                      --short-names (-s), # Only print the file names, and not the path
                      --full-paths (-f),  # display paths as absolute paths
                      --du (-d),          # Display the apparent directory size ("disk usage") in place of the directory metadata size
                      --directory (-D),   # List the specified directory itself instead of its contents
                      --mime-type (-m),   # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
                      --threads (-t),     # Use multiple threads to list contents. Output will be non-deterministic.
                      ...pattern: glob,   # The glob pattern to use.
                  ]: [ nothing -> table ] {
                      let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
                      (ls-builtin
                          --all=$all
                          --long=$long
                          --short-names=$short_names
                          --full-paths=$full_paths
                          --du=$du
                          --directory=$directory
                          --mime-type=$mime_type
                          --threads=$threads
                          ...$pattern
                      ) | sort-by type name -i
                  }

                  def v [
                    ...pattern: glob
                  ] : [ nothing -> nothing ] {
                    let patter = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
                    (nvim ...$pattern)
                  }
        '';

        shellAliases = {
          # vi = "nvim";
          # vim = "nvim";
          # v = "nvim";
        };
      };

      carapace.enable = true;
      carapace.enableNushellIntegration = true;

      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [
          "--cmd cd"
        ];
      };
    };
  };
}
