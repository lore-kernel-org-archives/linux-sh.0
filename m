From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 24 Dec 2013 14:15:55 +0000
Subject: [PATCH 15/29] ARM: shmobile: r8a7740: Declare SCIF register base and IRQ as resources
Message-Id: <8bf2f8c5ccd4119b9e4bba6c2db5c93c237a84cb.1387888861.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Passing the register base address and IRQ through platform data is
deprecated. Use resources instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8778b57..81a4366 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -207,16 +207,21 @@ static struct platform_device irqpin3_device = {
 #define R8A7740_SCIF(scif_type, index, baseaddr, irq)		\
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= scif_type,				\
-	.mapbase	= baseaddr,				\
 	.flags		= UPF_BOOT_AUTOCONF,			\
-	.irqs		= SCIx_IRQ_MUXED(irq),			\
 	.scbrr_algo_id	= SCBRR_ALGO_4,				\
 	.scscr		= SCSCR_RE | SCSCR_TE,			\
 };								\
 								\
+static struct resource scif##index##_resources[] = {		\
+	DEFINE_RES_MEM(baseaddr, 0x100),			\
+	DEFINE_RES_IRQ(irq),					\
+};								\
+								\
 static struct platform_device scif##index##_device = {		\
 	.name		= "sh-sci",				\
 	.id		= index,				\
+	.resource	= scif##index##_resources,		\
+	.num_resources	= ARRAY_SIZE(scif##index##_resources),	\
 	.dev		= {					\
 		.platform_data	= &scif##index##_platform_data,	\
 	},							\
-- 
1.8.4

