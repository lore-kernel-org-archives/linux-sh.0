From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 29 Sep 2009 11:02:02 +0000
Subject: [PATCH] sh: mach-ecovec24: modify MTD mask_flags typo
Message-Id: <uhbumqaj9.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch modify bug which can erase boot loader image area.

Tested-by: Yusuke Goda <goda.yusuke@renesas.com>
Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 5f9881e..ae2cc0d 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -70,7 +70,7 @@ static struct mtd_partition nor_flash_partitions[] = {
 		.name = "boot loader",
 		.offset = 0,
 		.size = (5 * 1024 * 1024),
-		.mask_flags = MTD_CAP_ROM,
+		.mask_flags = MTD_CAP_RAM,
 	}, {
 		.name = "free-area",
 		.offset = MTDPART_OFS_APPEND,
-- 
1.6.0.4

