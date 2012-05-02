From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 02 May 2012 09:41:40 +0000
Subject: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Artem Bityutskiy <dedekind1@gmail.com>

changelog v3:

Just a rebase on current l2-mtd.git.

changelog v2:
  - extract the iounmap calls from patch "Add support for error IRQ" into a new patch.
  - swapped patches "Add support for error IRQ" and "Add error IRQ resource"
  - corrected an indentation mistake

This series cleans up the flctl when run in hardware ecc mode. The first 2 patches make sure we catch all errors that result from hardware transmission. The other patches handle how the ecc is layed out, correct some code to write and read it and make sure we propagate the statistics about errors/repairs to the nand base.

Bastian Hecht (10):
  mtd: sh_flctl: Add missing iounmap()
  ARM: sh-mobile: mackerel: Add error IRQ resource
  mtd: sh_flctl: Add support for error IRQ
  mtd: sh_flctl: Use different OOB layout
  mtd: sh_flctl: Fix hardware ECC behaviour
  mtd: sh_flctl: Simplify the hardware ecc page read/write
  mtd: sh_flctl: Group sector accesses into a single transfer
  mtd: sh_flctl: Restructure the hardware ECC handling
  mtd: sh_flctl: Use user oob data in hardware ECC mode
  ARM: sh-mobile: mackerel: Use hardware error correction

 arch/arm/mach-shmobile/board-mackerel.c |    7 +-
 drivers/mtd/nand/sh_flctl.c             |  296 ++++++++++++++++++-------------
 include/linux/mtd/sh_flctl.h            |   23 ++-
 3 files changed, 193 insertions(+), 133 deletions(-)

-- 
1.7.5.4

