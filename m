From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 08 Nov 2010 05:45:09 +0000
Subject: [PATCH ARM: mach-shmobile: ap4evb: MTD loader become readonly
Message-Id: <w3py694v063.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Yusuke Goda <yusuke.goda.sx@renesas.com>

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 0de010e..ed92604 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -159,11 +159,13 @@ static struct mtd_partition nor_flash_partitions[] = {
 		.name		= "loader",
 		.offset		= 0x00000000,
 		.size		= 512 * 1024,
+		.mask_flags	= MTD_WRITEABLE,
 	},
 	{
 		.name		= "bootenv",
 		.offset		= MTDPART_OFS_APPEND,
 		.size		= 512 * 1024,
+		.mask_flags	= MTD_WRITEABLE,
 	},
 	{
 		.name		= "kernel_ro",
-- 
1.7.0.4

