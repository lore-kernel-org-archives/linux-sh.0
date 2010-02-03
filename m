From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 15:03:57 +0000
Subject: [PATCH 4/4] sh: activate runtime PM for dmaengine on sh7722 and
Message-Id: <Pine.LNX.4.64.1002031600180.6324@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    3 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 5d7dc19..0ae9855 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -145,6 +145,9 @@ struct platform_device dma_device = {
 	.dev		= {
 		.platform_data	= &dma_platform_data,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_DMAC,
+	},
 };
 
 /* Serial */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index b692e61..e61063f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -156,6 +156,9 @@ static struct platform_device dma0_device = {
 	.dev	= {
 		.platform_data	= &dma0_platform_data,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_DMAC0,
+	},
 };
 
 static struct platform_device dma1_device = {
@@ -166,6 +169,9 @@ static struct platform_device dma1_device = {
 	.dev	= {
 		.platform_data	= &dma1_platform_data,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_DMAC1,
+	},
 };
 
 /* Serial */
-- 
1.6.2.4

