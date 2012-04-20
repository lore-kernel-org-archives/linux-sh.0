From: Bastian Hecht <hechtb@googlemail.com>
Date: Fri, 20 Apr 2012 09:13:41 +0000
Subject: [PATCH 0/9] sh_flctl hardware ECC mode cleanup
Message-Id: <1334913230-23615-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

This series cleans up the flctl when run in hardware ecc mode. The first 2 patches make sure we catch all errors that result from hardware transmission. The other patches handle how the ecc is layed out, correct some code to write and read it and make sure we propagate the statistics about errors/repairs to the nand base.

Bastian Hecht (9):
  mtd: sh_flctl: Add support for error IRQ
  ARM: sh-mobile: mackerel: Add error IRQ resource
  mtd: sh_flctl: Use different OOB layout
  mtd: sh_flctl: Fix hardware ECC behaviour
  mtd: sh_flctl: Simplify the hardware ecc page read
  mtd: sh_flctl: Group sector accesses into a single transfer
  mtd: sh_flctl: Restructure the hardware ECC handling
  mtd: sh_flctl: Use user oob data in hardware ECC mode
  ARM: sh-mobile: mackerel: Use hardware error correction

 arch/arm/mach-shmobile/board-mackerel.c |    7 +-
 drivers/mtd/nand/sh_flctl.c             |  289 ++++++++++++++++++-------------
 include/linux/mtd/sh_flctl.h            |   21 ++-
 3 files changed, 188 insertions(+), 129 deletions(-)

-- 
1.7.5.4

