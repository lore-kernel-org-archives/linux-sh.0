From: Bastian Hecht <hechtb@googlemail.com>
Date: Mon, 14 May 2012 12:14:39 +0000
Subject: [PATCH v4 0/8] sh_flctl hardware ECC mode cleanup
Message-Id: <1336997687-6868-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, linux-sh@vger.kernel.org

changelog v4:

  - removed arch/arm related patches
  - rebased on current l2-mtd.git
  - fixed some compiler warnings
	- patch 2: use "int irq" when removing irq binding in error case to fix smatch breakage
	- patch 7 and 8: just directly use the void __iomem pointer instead of the unprecise void pointer to fix sparse breakage

changelog v3:

Just a rebase on current l2-mtd.git.

changelog v2:
  - extract the iounmap calls from patch "Add support for error IRQ" into a new patch.
  - swapped patches "Add support for error IRQ" and "Add error IRQ resource"
  - corrected an indentation mistake

This series cleans up the flctl when run in hardware ecc mode. The first 2 patches make sure we catch all errors that result from hardware transmission. The other patches handle how the ecc is layed out, correct some code to write and read it and make sure we propagate the statistics about errors/repairs to the nand base.

Bastian Hecht (8):
  mtd: sh_flctl: Add missing iounmap()
  mtd: sh_flctl: Add support for error IRQ
  mtd: sh_flctl: Use different OOB layout
  mtd: sh_flctl: Fix hardware ECC behaviour
  mtd: sh_flctl: Simplify the hardware ecc page read/write
  mtd: sh_flctl: Group sector accesses into a single transfer
  mtd: sh_flctl: Restructure the hardware ECC handling
  mtd: sh_flctl: Use user oob data in hardware ECC mode

 drivers/mtd/nand/sh_flctl.c  |  299 ++++++++++++++++++++++++------------------
 include/linux/mtd/sh_flctl.h |   23 +++-
 2 files changed, 187 insertions(+), 135 deletions(-)

-- 
1.7.5.4

