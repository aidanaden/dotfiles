{...}: {
  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "aidanaden";
    userEmail = "aidanaden@hotmail.com";
    #signing = {
    #  key = null; # gnupg decides by mail
    #  signByDefault = true;
    #};
    includes = [
      # {
      #   condition = "gitdir:~/code/rtl/";
      #   contents.user.email = "felix.breuer@rtl-extern.de";
      # }
      # {
      #   condition = "gitdir:~/code/inovex/";
      #   contents.user.email = "felix.breuer@inovex.de";
      # }
      # {
      #   condition = "gitdir:~/code/controlf/";
      #   contents = {
      #     commit.gpgSign = false;
      #     user = {
      #       email = "felix@controlf.io";
      #       name = "Felix Breuer";
      #     };
      #   };
      # }
    ];
    aliases = {
      cm = "commit";
      ca = "commit --amend --no-edit";
      co = "checkout";
      cp = "cherry-pick";

      di = "diff";
      dh = "diff HEAD";

      pu = "pull";
      ps = "push";
      pf = "push --force-with-lease";

      st = "status -sb";
      fe = "fetch";
      gr = "grep -in";

      ri = "rebase -i";
      rc = "rebase --continue";
    };
    ignores = [
      # ide
      ".idea"
      ".vs"
      ".vsc"
      ".vscode"
      # npm
      "node_modules"
      "npm-debug.log"
      # python
      "__pycache__"
      "*.pyc"

      ".ipynb_checkpoints" # jupyter
      "__sapper__" # svelte
      ".DS_Store" # mac
    ];
    extraConfig = {
      init.defaultBranch = "main";
      pull = {
        ff = false;
        commit = false;
        rebase = false;
      };
      fetch = {prune = true;};
      push.autoSetupRemote = true;
      delta = {line-numbers = true;};
    };
  };
}