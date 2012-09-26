From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 26 Sep 2012 09:05:04 +0000
Subject: [PATCH 1/3] mtd: sh_flctl: Probe SNAND_E flag from NAND chip
Message-Id: <1348650306-15492-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

SNAND_E indicates whether we deal with 512kB or 2048kB page sizes. We
can probe this from the NAND chip itself and don't need to specify it in
the platform data anymore.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
Based on l2-mtd with reverted commit e26c113b4130aefa1d8446602bb5b05cfd646bfe
and the 2 patches posted 3 days ago (09/23)
mtd: sh_flctl: Setup and release DMA channels
and
mtd: sh_flctl: Use DMA for data fifo FLTDFIFO when available

 drivers/mtd/nand/sh_flctl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 0d90af8..8f0bed1 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -970,6 +970,7 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 		}
 	} else {
 		flctl->page_size = 1;
+		flctl->flcmncr_base |= SNAND_E;
 		if (chip->chipsize > (128 << 20)) {
 			/* big than 128MB */
 			flctl->rw_ADRCNT = ADRCNT2_E;
-- 
1.7.5.4

