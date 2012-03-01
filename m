From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 01 Mar 2012 09:48:37 +0000
Subject: [PATCH v3 3/7] mtd: sh_flctl: Expand the READID command to 8 bytes
Message-Id: <1330595321-2728-3-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

The nand base code wants to read out 8 bytes in the READID command.
Reflect this in the driver code.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
changelog: There was an inconsistency between patch 2/7 and 3/7. An empty_fifo() call has been moved around to correct it.

 drivers/mtd/nand/sh_flctl.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 9291066..407acb5 100644
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
@@ -559,13 +560,18 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
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
 		empty_fifo(flctl);
 		start_translation(flctl);
-		read_datareg(flctl, 0);	/* read and end */
+		read_fiforeg(flctl, flctl->read_bytes, 0);
+		wait_completion(flctl);
 		break;
 
 	case NAND_CMD_ERASE1:
-- 
1.7.5.4

