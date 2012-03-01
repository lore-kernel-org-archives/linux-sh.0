From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 01 Mar 2012 09:48:38 +0000
Subject: [PATCH v3 4/7] mtd: sh_flctl: Implement NAND_CMD_RNDOUT command
Message-Id: <1330595321-2728-4-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

Implements the command to seek and read in pages.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
changelog: the code only works for software ecc. Make this explicit in
the code

 drivers/mtd/nand/sh_flctl.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 407acb5..655ff2d 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -303,6 +303,7 @@ static void set_cmd_regs(struct mtd_info *mtd, uint32_t cmd, uint32_t flcmcdr_va
 		break;
 	case NAND_CMD_READ0:
 	case NAND_CMD_READOOB:
+	case NAND_CMD_RNDOUT:
 		addr_len_bytes = flctl->rw_ADRCNT;
 		flcmdcr_val |= CDSRC_E;
 		if (flctl->chip.options & NAND_BUSWIDTH_16)
@@ -558,6 +559,21 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		flctl->read_bytes = mtd->oobsize;
 		goto read_normal_exit;
 
+	case NAND_CMD_RNDOUT:
+		if (flctl->hwecc)
+			break;
+
+		if (flctl->page_size)
+			set_cmd_regs(mtd, command, (NAND_CMD_RNDOUTSTART << 8)
+				| command);
+		else
+			set_cmd_regs(mtd, command, command);
+
+		set_addr(mtd, column, 0);
+
+		flctl->read_bytes = mtd->writesize + mtd->oobsize - column;
+		goto read_normal_exit;
+
 	case NAND_CMD_READID:
 		set_cmd_regs(mtd, command, command);
 
-- 
1.7.5.4

