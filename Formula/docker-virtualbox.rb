require 'formula'

class Sshpass < Formula
  depends_on cask: 'virtualbox'
  depends_on 'docker-cli'
  depends_on 'docker-compose'
  depends_on 'docker-machine'
  depends_on 'docker-machine-nfs'

  keg_only "this package may conflict with official docker"

  def install
    # Move everything under #{libexec}/
    libexec.install Dir["*"]

    # Then write executables under #{bin}/
    bin.write_exec_script (libexec/"docker-machine-init.sh")
    bin.write_exec_script (libexec/"docker.sh")
  end

  def caveats
      s = <<~EOS
        Docker Virtualbox was installed

        Please dont forget to add docker alias to your rcfile

        For ZSH
        echo "alias docker=#{opt_bin}/docker.sh" >> ~/.zshrc

        For BASH
        echo "alias docker=#{opt_bin}/docker.sh" >> ~/.bashrc
      EOS
      s
    end

    def plist; <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/docker-machine-init.sh</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{datadir}</string>
      </dict>
      </plist>
    EOS
    end
end
