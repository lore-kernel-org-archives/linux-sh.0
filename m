From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jun 2010 07:45:25 +0000
Subject: [GIT PULL] sh updates for 2.6.35-rc4
Message-Id: <20100622074525.GA20140@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-linus

Which contains:

Huang Weiyi (1):
      sh: remove duplicated #include

Julia Lawall (1):
      arch/sh/mm: Eliminate a double lock

Paul Mundt (2):
      sh: Fix up IORESOURCE_PCI_FIXED usage in pcibios_fixup_device_resources().
      clocksource: sh_cmt: Fix up bogus shift value.

 arch/sh/boards/mach-ecovec24/setup.c |    1 -
 arch/sh/drivers/pci/pci.c            |    2 --
 arch/sh/mm/pmb.c                     |    2 +-
 drivers/clocksource/sh_cmt.c         |    2 +-
 4 files changed, 2 insertions(+), 5 deletions(-)
