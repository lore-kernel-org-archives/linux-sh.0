From: horseriver <horserivers@gmail.com>
Date: Mon, 04 Feb 2013 23:14:32 +0000
Subject: makefile command
Message-Id: <20130204231432.GI2553@debian.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

hi:)

  what does this command do for makefile?

  install: $(BOOTIMAGE)
  sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"

  
thanks!
