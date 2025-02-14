{pkgs, ...}: {
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      lspBuf = {
        K = "hover";
        ga = "code_action";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gr = "rename";
        gt = "type_definition";
      };
    };
    servers = {
      # python
      basedpyright.enable = true;
      ruff.enable = true;
      # typst
      tinymist.enable = true;
      # lua
      lua_ls.enable = true;
      # webdev
      html.enable = true;
      biome.enable = true;
      # java
      jdtls = {
        enable = true;
        extraOptions.init_options.jvm_args = ["-javaagent:${pkgs.lombok}/share/java/lombok.jar"];
      };
      # docker
      dockerls.enable = true;
      docker_compose_language_service = {
        enable = true;
        filetypes = ["yaml"];
      };
      # nix
      nil_ls = {
        enable = true;
        settings = {
          nix.flake.autoArchive = true;
          formatting.command = null;
        };
      };
      # terraform
      terraformls.enable = true;
      tflint.enable = true;
    };
  };
}
