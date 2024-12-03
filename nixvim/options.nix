{
  programs.nixvim = {
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };

    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };
    opts = {
      updatetime = 100;

      number = true;
      relativenumber = true;
      hidden = true;
      scrolloff = 4;
      signcolumn = "yes:1";
      wrap = false;
      splitbelow = true;
      splitright = true;
      undofile = true;

      ignorecase = true;
      smartcase = true;

      cursorline = true;
      laststatus = 3;
      autoindent = true;
    };
  };
}
