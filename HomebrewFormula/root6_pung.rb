class Root6Pung < Formula
  homepage "https://root.cern.ch"
  url "https://root.cern.ch/download/root_v6.06.06.macosx64-10.11-clang73.tar.gz"
  sha256 "5ce6a0f894699f207a36b09eed8aeba618a6eb5b5d8a341f0d0d6b09daa24d66"
  version "6.06.06"

  def install
    (prefix+'root').install Dir["*"]
    (libexec+'set_root6.sh').write  <<-EOS.undent
      alias useroot6="source #{prefix}/root/bin/thisroot.sh;which root"
      function root6(){ ( useroot6; exec root $*)}
      alias r6=root6
    EOS
    (libexec+'set_root6_pung.sh').write  <<-EOS.undent
      alias useroot6_pung="source #{prefix}/root/bin/thisroot.sh;which root"
      function root6_pung(){ ( useroot6_pung; exec root $*)}
    EOS
    (libexec+'root6_pung').write  <<-EOS.undent
      #!/bin/bash
      source #{prefix}/root/bin/thisroot.sh
      echo "#{prefix}/root/bin/root"
      #{prefix}/root/bin/root $*
    EOS
    bin.install libexec+'root6_pung'
  end
  def caveats; <<-EOS.undent
    To use root6_pung, you have 3 options

    1. Just type "root6_pung". It's a small wraper script to run root.

    2. Put the next line into your .bash_profile. 
        . $(brew --prefix root6_pung)/libexec/set_root6_pung.sh
      This will make 2 alias/function
        * useroot6_pung : an alias to set root environment
        * root6_pung    : an function to run root without enviroment configurations.

    3. The next alternative way will generator even shorter command.
        . $(brew --prefix root6_pung)/libexec/set_root6.sh
       This will make
        * useroot6
        * root6
        * r6            : alias of root6

    A robust way to make them easy is just
        echo '. $(brew --prefix root6_pung)/libexec/set_root6.sh' >> ~/.bash_profile

    Have fun!
    EOS
  end
  def prefix_root
    prefix+'root'
  end
end