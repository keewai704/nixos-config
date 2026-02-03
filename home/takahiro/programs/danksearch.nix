{ pkgs, ... }:
{
  programs.dsearch = {
    enable = true;
    config = {
      listen_addr = ":43654";
      index_path = "~/.cache/danksearch/index";
      max_file_bytes = 2097152;
      worker_count = 4;
      index_all_files = true;
      auto_reindex = false;
      reindex_interval_hours = 24;
      text_extensions = [
        ".txt" ".md" ".go" ".py" ".js" ".ts"
        ".jsx" ".tsx" ".json" ".yaml" ".yml"
        ".toml" ".html" ".css" ".rs" ".nix"
      ];
      index_paths = [
        {
          path = "~/Documents";
          max_depth = 6;
          exclude_hidden = true;
          exclude_dirs = [ "node_modules" "venv" "target" ];
        }
        {
          path = "~/Projects";
          max_depth = 8;
          exclude_hidden = true;
          exclude_dirs = [ "node_modules" ".git" "target" "dist" ];
        }
      ];
    };
  };
}
