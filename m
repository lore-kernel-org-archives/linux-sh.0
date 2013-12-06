From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 06 Dec 2013 09:59:47 +0000
Subject: [PATCH 40/47] ARM: shmobile: r8a7791: Don't set plat_sci_port scbrr_algo_id field
Message-Id: <1386323994-12850-41-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/setup-r8a7791.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index f15b537..e28404e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -84,11 +84,10 @@ void __init r8a7791_pinmux_init(void)
 	r8a7791_register_gpio(7);
 }
 
-#define __R8A7791_SCIF(scif_type, algo, index, baseaddr, irq)		\
+#define __R8A7791_SCIF(scif_type, index, baseaddr, irq)			\
 static struct plat_sci_port scif##index##_platform_data = {		\
 	.type		= scif_type,					\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,		\
-	.scbrr_algo_id	= algo,						\
 	.scscr		= SCSCR_RE | SCSCR_TE,				\
 };									\
 									\
@@ -98,13 +97,13 @@ static struct resource scif##index##_resources[] = {			\
 }
 
 #define R8A7791_SCIF(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIF, SCBRR_ALGO_2, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIF, index, baseaddr, irq)
 
 #define R8A7791_SCIFA(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIFA, SCBRR_ALGO_4, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIFA, index, baseaddr, irq)
 
 #define R8A7791_SCIFB(index, baseaddr, irq)				\
-	__R8A7791_SCIF(PORT_SCIFB, SCBRR_ALGO_4, index, baseaddr, irq)
+	__R8A7791_SCIF(PORT_SCIFB, index, baseaddr, irq)
 
 R8A7791_SCIFA(0,  0xe6c40000, gic_spi(144)); /* SCIFA0 */
 R8A7791_SCIFA(1,  0xe6c50000, gic_spi(145)); /* SCIFA1 */
-- 
1.8.3.2

