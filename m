From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 08 Feb 2012 12:16:46 +0000
Subject: [PATCH 2/7] mtd: sh_flctl: Reorder empty_fifo() calls
Message-Id: <1328703411-3452-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328703411-3452-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1328703411-3452-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Bastian Hecht <hechtb@gmail.com>, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com

Reorders the calls to make it a bit shorter and match the calling
procedure displayed in the datasheet.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 93b1f74..8c97367 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -525,7 +525,6 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			execmd_read_page_sector(mtd, page_addr);
 			break;
 		}
-		empty_fifo(flctl);
 		if (flctl->page_size)
 			set_cmd_regs(mtd, command, (NAND_CMD_READSTART << 8)
 				| command);
@@ -547,7 +546,6 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			break;
 		}
 
-		empty_fifo(flctl);
 		if (flctl->page_size) {
 			set_cmd_regs(mtd, command, (NAND_CMD_READSTART << 8)
 				| NAND_CMD_READ0);
@@ -560,7 +558,6 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		goto read_normal_exit;
 
 	case NAND_CMD_READID:
-		empty_fifo(flctl);
 		set_cmd_regs(mtd, command, command);
 		set_addr(mtd, 0, 0);
 
@@ -654,6 +651,7 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 read_normal_exit:
 	writel(flctl->read_bytes, FLDTCNTR(flctl));	/* set read size */
+	empty_fifo(flctl);
 	start_translation(flctl);
 	read_fiforeg(flctl, flctl->read_bytes, 0);
 	wait_completion(flctl);
-- 
1.7.5.4

