From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 06 Dec 2013 09:59:46 +0000
Subject: [PATCH 39/47] ARM: shmobile: r8a7790: Don't set plat_sci_port scbrr_algo_id field
Message-Id: <1386323994-12850-40-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 70bb553..bb805a4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -78,11 +78,10 @@ void __init r8a7790_pinmux_init(void)
 	r8a7790_register_gpio(5);
 }
 
-#define __R8A7790_SCIF(scif_type, _scscr, algo, index, baseaddr, irq)	\
+#define __R8A7790_SCIF(scif_type, _scscr, index, baseaddr, irq)		\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scbrr_algo_id	= algo,						\
 	.scscr		= _scscr,					\
 };									\
 									\
@@ -93,19 +92,19 @@ static struct resource scif##index##_resources[] = {			\
 
 #define R8A7790_SCIF(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIF, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_2, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_SCIFA(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIFA, SCSCR_RE | SCSCR_TE | SCSCR_CKE0,	\
-		       SCBRR_ALGO_4, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_SCIFB(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_SCIFB, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_4, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 #define R8A7790_HSCIF(index, baseaddr, irq)				\
 	__R8A7790_SCIF(PORT_HSCIF, SCSCR_RE | SCSCR_TE,			\
-		       SCBRR_ALGO_6, index, baseaddr, irq)
+		       index, baseaddr, irq)
 
 R8A7790_SCIFA(0, 0xe6c40000, gic_spi(144)); /* SCIFA0 */
 R8A7790_SCIFA(1, 0xe6c50000, gic_spi(145)); /* SCIFA1 */
-- 
1.8.3.2

