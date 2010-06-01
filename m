From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 01 Jun 2010 02:40:05 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: evt2irq() update for MMCIF
Message-Id: <w3p39x7earf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch updates the irq numbers for MMCIF
to make use of evt2irq().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index bdc4c6b..67da737 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -267,12 +267,12 @@ static struct resource sh_mmcif_resources[] = {
 	},
 	[1] = {
 		/* MMC ERR */
-		.start	= 198,
+		.start	= evt2irq(0x1ac0),
 		.flags	= IORESOURCE_IRQ,
 	},
 	[2] = {
 		/* MMC NOR */
-		.start	= 199,
+		.start	= evt2irq(0x1ae0),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.0.4

