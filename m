From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Jan 2013 09:40:42 +0000
Subject: [PATCH] ARM: shmobile: r8a7779: scif .irqs used SCIx_IRQ_MUXED()
Message-Id: <878v7q7rsa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch tidyup scif .irqs settings by using
SCIx_IRQ_MUXED() macro.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 7a1ad4f..2071fee 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -66,8 +66,7 @@ static struct plat_sci_port scif0_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(88), gic_spi(88),
-			    gic_spi(88), gic_spi(88) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(88)),
 };
 
 static struct platform_device scif0_device = {
@@ -84,8 +83,7 @@ static struct plat_sci_port scif1_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(89), gic_spi(89),
-			    gic_spi(89), gic_spi(89) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(89)),
 };
 
 static struct platform_device scif1_device = {
@@ -102,8 +100,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(90), gic_spi(90),
-			    gic_spi(90), gic_spi(90) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(90)),
 };
 
 static struct platform_device scif2_device = {
@@ -120,8 +117,7 @@ static struct plat_sci_port scif3_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(91), gic_spi(91),
-			    gic_spi(91), gic_spi(91) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(91)),
 };
 
 static struct platform_device scif3_device = {
@@ -138,8 +134,7 @@ static struct plat_sci_port scif4_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(92), gic_spi(92),
-			    gic_spi(92), gic_spi(92) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(92)),
 };
 
 static struct platform_device scif4_device = {
@@ -156,8 +151,7 @@ static struct plat_sci_port scif5_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { gic_spi(93), gic_spi(93),
-			    gic_spi(93), gic_spi(93) },
+	.irqs		= SCIx_IRQ_MUXED(gic_spi(93)),
 };
 
 static struct platform_device scif5_device = {
-- 
1.7.9.5

