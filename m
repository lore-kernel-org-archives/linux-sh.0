From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 23 Mar 2011 09:29:16 +0000
Subject: [PATCH] ARM: mach-shmobile: add coherent DMA mask to CEU camera
Message-Id: <Pine.LNX.4.64.1103231025560.6836@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>

Cameras are currently broken on ARM sh-mobile platforms. They need a
suitable coherent DMA mask.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    3 ++-
 arch/arm/mach-shmobile/board-mackerel.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 81d6536..77bf226 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -923,7 +923,8 @@ static struct platform_device ceu_device = {
 	.num_resources	= ARRAY_SIZE(ceu_resources),
 	.resource	= ceu_resources,
 	.dev	= {
-		.platform_data	= &sh_mobile_ceu_info,
+		.platform_data		= &sh_mobile_ceu_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 063a320..71de352 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -887,7 +887,8 @@ static struct platform_device ceu_device = {
 	.num_resources	= ARRAY_SIZE(ceu_resources),
 	.resource	= ceu_resources,
 	.dev		= {
-		.platform_data	= &sh_mobile_ceu_info,
+		.platform_data		= &sh_mobile_ceu_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 
-- 
1.7.2.5

