From: Bastian Hecht <hechtb@googlemail.com>
Date: Sat, 11 Feb 2012 11:45:01 +0000
Subject: [PATCH v2 3/7] mtd: sh_flctl: Expand the READID command to 8 bytes
Message-Id: <1328960705-18699-4-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

The nand base code wants to read out 8 bytes in the READID command.
Reflect this in the driver code.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
changelog: exactly same as patch v1.

 drivers/mtd/nand/sh_flctl.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 8c97367..407acb5 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -320,6 +320,7 @@ static void set_cmd_regs(struct mtd_info *mtd, uint32_t cmd, uint32_t flcmcdr_va
 		break;
 	case NAND_CMD_READID:
 		flcmncr_val &= ~SNAND_E;
+		flcmdcr_val |= CDSRC_E;
 		addr_len_bytes = ADRCNT_1;
 		break;
 	case NAND_CMD_STATUS:
@@ -559,12 +560,18 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 	case NAND_CMD_READID:
 		set_cmd_regs(mtd, command, command);
-		set_addr(mtd, 0, 0);
 
-		flctl->read_bytes = 4;
+		/* READID is always performed using an 8-bit bus */
+		if (flctl->chip.options & NAND_BUSWIDTH_16)
+			column <<= 1;
+		set_addr(mtd, column, 0);
+
+		flctl->read_bytes = 8;
 		writel(flctl->read_bytes, FLDTCNTR(flctl)); /* set read size */
+		empty_fifo(flctl);
 		start_translation(flctl);
-		read_datareg(flctl, 0);	/* read and end */
+		read_fiforeg(flctl, flctl->read_bytes, 0);
+		wait_completion(flctl);
 		break;
 
 	case NAND_CMD_ERASE1:
-- 
1.7.5.4

