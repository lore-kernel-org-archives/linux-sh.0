From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 02 Feb 2010 04:06:28 +0000
Subject: [GIT PULL] sh updates for 2.6.33-rc7
Message-Id: <20100202040628.GH13428@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.33

Which contains:

Magnus Damm (1):
      usb: r8a66597-hdc disable interrupts fix

Marek Skuczynski (2):
      sh: Fix access to released memory in dwarf_unwinder_cleanup()
      sh: Fix access to released memory in clk_debugfs_register_one()

Markus Pietrek (1):
      spi: spi_sh_msiof: Fixed data sampling on the correct edge

 arch/sh/kernel/cpu/clock.c      |    4 ++--
 arch/sh/kernel/dwarf.c          |    8 ++++----
 drivers/spi/spi_sh_msiof.c      |   15 ++++++---------
 drivers/usb/host/r8a66597-hcd.c |   17 ++++++++++++++++-
 4 files changed, 28 insertions(+), 16 deletions(-)
