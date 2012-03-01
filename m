From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 01 Mar 2012 09:48:36 +0000
Subject: [PATCH v3 2/7] mtd: sh_flctl: Reorder empty_fifo() calls
Message-Id: <1330595321-2728-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

Reorders the calls to make it a bit shorter and match the calling
procedure displayed in the datasheet.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
changelog: There was an inconsistency between patch 2/7 and 3/7. An empty_fifo() call has been moved around to correct it.

 drivers/mtd/nand/sh_flctl.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 93b1f74..9291066 100644
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
@@ -560,12 +558,12 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 		goto read_normal_exit;
 
 	case NAND_CMD_READID:
-		empty_fifo(flctl);
 		set_cmd_regs(mtd, command, command);
 		set_addr(mtd, 0, 0);
 
 		flctl->read_bytes = 4;
 		writel(flctl->read_bytes, FLDTCNTR(flctl)); /* set read size */
+		empty_fifo(flctl);
 		start_translation(flctl);
 		read_datareg(flctl, 0);	/* read and end */
 		break;
@@ -654,6 +652,7 @@ static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
 
 read_normal_exit:
 	writel(flctl->read_bytes, FLDTCNTR(flctl));	/* set read size */
+	empty_fifo(flctl);
 	start_translation(flctl);
 	read_fiforeg(flctl, flctl->read_bytes, 0);
 	wait_completion(flctl);
-- 
1.7.5.4

