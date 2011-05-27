From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 27 May 2011 10:44:58 +0000
Subject: [PATCH 3/3] ARM: mach-shmobile: add coherent DMA mask for SDHI
Message-Id: <Pine.LNX.4.64.1105271243390.25265@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

It is now required, because the SDHI / TMIO driver is using
dma_alloc_coherent() to allocate the DMA bounce buffer.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ag5evm.c   |    6 ++++--
 arch/arm/mach-shmobile/board-ap4evb.c   |    6 ++++--
 arch/arm/mach-shmobile/board-mackerel.c |    9 ++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index c95258c..a5a737c 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -372,7 +372,8 @@ static struct platform_device sdhi0_device = {
 	.num_resources	= ARRAY_SIZE(sdhi0_resources),
 	.resource	= sdhi0_resources,
 	.dev	= {
-		.platform_data	= &sdhi0_info,
+		.platform_data		= &sdhi0_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 
@@ -415,7 +416,8 @@ static struct platform_device sdhi1_device = {
 	.name		= "sh_mobile_sdhi",
 	.id		= 1,
 	.dev		= {
-		.platform_data	= &sh_sdhi1_platdata,
+		.platform_data		= &sh_sdhi1_platdata,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 	.num_resources	= ARRAY_SIZE(sdhi1_resources),
 	.resource	= sdhi1_resources,
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 08acb6e..2b139bd 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -335,7 +335,8 @@ static struct platform_device sdhi0_device = {
 	.resource       = sdhi0_resources,
 	.id             = 0,
 	.dev	= {
-		.platform_data	= &sdhi0_info,
+		.platform_data		= &sdhi0_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 
@@ -376,7 +377,8 @@ static struct platform_device sdhi1_device = {
 	.resource       = sdhi1_resources,
 	.id             = 1,
 	.dev	= {
-		.platform_data	= &sdhi1_info,
+		.platform_data		= &sdhi1_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 888fd30..9ee66d1 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -901,7 +901,8 @@ static struct platform_device sdhi0_device = {
 	.resource	= sdhi0_resources,
 	.id		= 0,
 	.dev	= {
-		.platform_data	= &sdhi0_info,
+		.platform_data		= &sdhi0_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 
@@ -944,7 +945,8 @@ static struct platform_device sdhi1_device = {
 	.resource	= sdhi1_resources,
 	.id		= 1,
 	.dev	= {
-		.platform_data	= &sdhi1_info,
+		.platform_data		= &sdhi1_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 #endif
@@ -995,7 +997,8 @@ static struct platform_device sdhi2_device = {
 	.resource	= sdhi2_resources,
 	.id		= 2,
 	.dev	= {
-		.platform_data	= &sdhi2_info,
+		.platform_data		= &sdhi2_info,
+		.coherent_dma_mask	= 0xffffffff,
 	},
 };
 
-- 
1.7.2.5

