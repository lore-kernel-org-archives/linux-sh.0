From: Bastian Hecht <hechtb@googlemail.com>
Date: Sat, 11 Feb 2012 11:44:58 +0000
Subject: [PATCH v2 0/7] SH Mobile sh_flctl driver brush up
Message-Id: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

This patch series brushs up the sh_flctl.c a bit to make it work with
the mackerel board. The hardware has changed and this needed to be
reflected in the NAND host driver.
On the road some minor enhancements have been incorporated.

Bastian Hecht (7):
  mtd: sh_flctl: Expand FLCMNCR register bit field
  mtd: sh_flctl: Reorder empty_fifo() calls
  mtd: sh_flctl: Expand the READID command to 8 bytes
  mtd: sh_flctl: Implement NAND_CMD_RNDOUT command
  mtd: sh_flctl: Use cached register value for FLCMNCR
  mtd: sh_flctl: Add FLHOLDCR register
  ARM: mach-shmobile: mackerel: Add the flash controller flctl

 arch/arm/mach-shmobile/board-mackerel.c |   71 +++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh7372.c   |    4 +-
 drivers/mtd/nand/sh_flctl.c             |   48 +++++++++++++--------
 include/linux/mtd/sh_flctl.h            |   37 ++++++++++++++++
 4 files changed, 141 insertions(+), 19 deletions(-)

-- 
1.7.5.4

