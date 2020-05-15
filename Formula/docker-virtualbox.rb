require 'formula'

class DockerVirtualbox < Formula
  url "https://github.com/sergeycherepanov/homebrew-docker-virtualbox.git", :using => :git
  version "0.0.2"
  revision 1

  depends_on 'terminal-notifier'
  depends_on 'docker-cli'
  depends_on 'docker-compose'
  depends_on 'docker-credential-helper'
  depends_on 'docker-machine'
  depends_on 'docker-machine-nfs'
  depends_on 'docker-machine-pf'

  keg_only "this package may conflict with official docker client"

  def install
    bin.install "bin/docker"
    bin.install "bin/docker-compose"
    bin.install "bin/docker-machine-init"
    prefix.install "assets/djocker.png"
  end

  def caveats
      s = <<~EOS
        Docker Virtualbox was installed

        Please don't forget to configure your PATH variable
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
          <string>#{opt_bin}/docker-machine-init</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>/tmp</string>
      </dict>
      </plist>
    EOS
    end
end
