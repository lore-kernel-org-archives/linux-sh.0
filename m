From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Feb 2010 16:50:22 +0000
Subject: [PATCH 5/5] sh: activate runtime PM for dmaengine on sh7722 and
Message-Id: <Pine.LNX.4.64.1002111744590.4484@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

No change - version 1 preserved.

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    3 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 3ce06c3..2b94281 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -163,6 +163,9 @@ struct platform_device dma_device = {
 	.dev		= {
 		.platform_data	= &dma_platform_data,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_DMAC,
+	},
 };
 
 /* Serial */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index cf829bf..ddc5694 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -189,6 +189,9 @@ static struct platform_device dma0_device = {
 	.dev		= {
 		.platform_data	= &dma0_platform_data,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_DMAC0,
+	},
 };
 
 static struct platform_device dma1_device = {
@@ -199,6 +202,9 @@ static struct platform_device dma1_device = {
 	.dev		= {
 		.platform_data	= &dma1_platform_data,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_DMAC1,
+	},
 };
 
 /* Serial */
-- 
1.6.2.4

