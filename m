From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Jun 2013 07:00:54 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: don't use external clock for SCIFs
Message-Id: <1371106854-25560-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106854-25560-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371106854-25560-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

This is an external component and may or may not be there, while the
internal clock always works.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 49de2d5..6531f3d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -64,10 +64,18 @@ void __init r8a7790_pinmux_init(void)
 [index] = {						\
 	SCIF_COMMON(PORT_SCIF, baseaddr, irq),		\
 	.scbrr_algo_id	= SCBRR_ALGO_2,			\
-	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
+	.scscr = SCSCR_RE | SCSCR_TE,	\
 }
 
-enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFA2, SCIF0, SCIF1 };
+#define HSCIF_DATA(index, baseaddr, irq)		\
+[index] = {						\
+	SCIF_COMMON(PORT_HSCIF, baseaddr, irq),		\
+	.scbrr_algo_id	= SCBRR_ALGO_6,			\
+	.scscr = SCSCR_RE | SCSCR_TE,	\
+}
+
+enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFA2, SCIF0, SCIF1,
+       HSCIF0, HSCIF1 };
 
 static const struct plat_sci_port scif[] = {
 	SCIFA_DATA(SCIFA0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
@@ -78,6 +86,8 @@ static const struct plat_sci_port scif[] = {
 	SCIFA_DATA(SCIFA2, 0xe6c60000, gic_spi(151)), /* SCIFA2 */
 	SCIF_DATA(SCIF0, 0xe6e60000, gic_spi(152)), /* SCIF0 */
 	SCIF_DATA(SCIF1, 0xe6e68000, gic_spi(153)), /* SCIF1 */
+	HSCIF_DATA(HSCIF0, 0xe62c0000, gic_spi(154)), /* HSCIF0 */
+	HSCIF_DATA(HSCIF1, 0xe62c8000, gic_spi(155)), /* HSCIF1 */
 };
 
 static inline void r8a7790_register_scif(int idx)
@@ -115,6 +125,8 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(SCIFA2);
 	r8a7790_register_scif(SCIF0);
 	r8a7790_register_scif(SCIF1);
+	r8a7790_register_scif(HSCIF0);
+	r8a7790_register_scif(HSCIF1);
 	r8a7790_register_irqc(0);
 }
 
-- 
1.8.2.1

