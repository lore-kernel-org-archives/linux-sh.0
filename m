From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 30 Sep 2009 00:50:30 +0000
Subject: [PATCH v2] sh: mach-ecovec24: modify 1st MTD area to read only
Message-Id: <uk4zh9rxl.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Tested-by: Yusuke Goda <goda.yusuke@renesas.com>
Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
this patch is v2 of 
[PATCH] sh: mach-ecovec24: modify MTD mask_flags typo

v1 -> v2

o MTD_CAP_RAM => MTD_WRITEABLE
o change Subject

 arch/sh/boards/mach-ecovec24/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 52912a6..0fb665d 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -71,7 +71,7 @@ static struct mtd_partition nor_flash_partitions[] = {
 		.name = "boot loader",
 		.offset = 0,
 		.size = (5 * 1024 * 1024),
-		.mask_flags = MTD_CAP_ROM,
+		.mask_flags = MTD_WRITEABLE,  /* force read-only */
 	}, {
 		.name = "free-area",
 		.offset = MTDPART_OFS_APPEND,
-- 
1.6.0.4

