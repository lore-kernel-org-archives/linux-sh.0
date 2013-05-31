From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 31 May 2013 15:57:02 +0000
Subject: [PATCH v3 2/5] ARM: shmobile: r8a7790: HSCIF support
Message-Id: <1370015825-29383-3-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds support for HSCIF0 and HSCIF1 on the r8a7790.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |    5 +++++
 arch/arm/mach-shmobile/setup-r8a7790.c |   14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index b393592..379bce6 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -181,6 +181,7 @@ static struct clk div6_clks[DIV6_NR] = {
 /* MSTP */
 enum {
 	MSTP721, MSTP720,
+	MSTP717, MSTP716,
 	MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
 	MSTP_NR
@@ -196,6 +197,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP204] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
 	[MSTP203] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
 	[MSTP202] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 2, 0), /* SCIFA2 */
+	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
+	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
 };
 
 static struct clk_lookup lookups[] = {
@@ -249,6 +252,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP721]),
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
+	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
+	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index ed7ee24..5b7a770 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -99,7 +99,15 @@ void __init r8a7790_pinmux_init(void)
 	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
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
@@ -110,6 +118,8 @@ static const struct plat_sci_port scif[] = {
 	SCIFA_DATA(SCIFA2, 0xe6c60000, gic_spi(151)), /* SCIFA2 */
 	SCIF_DATA(SCIF0, 0xe6e60000, gic_spi(152)), /* SCIF0 */
 	SCIF_DATA(SCIF1, 0xe6e68000, gic_spi(153)), /* SCIF1 */
+	HSCIF_DATA(HSCIF0, 0xe62c0000, gic_spi(154)), /* HSCIF0 */
+	HSCIF_DATA(HSCIF1, 0xe62c8000, gic_spi(155)), /* HSCIF1 */
 };
 
 static inline void r8a7790_register_scif(int idx)
@@ -147,6 +157,8 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(SCIFA2);
 	r8a7790_register_scif(SCIF0);
 	r8a7790_register_scif(SCIF1);
+	r8a7790_register_scif(HSCIF0);
+	r8a7790_register_scif(HSCIF1);
 	r8a7790_register_irqc(0);
 }
 
-- 
1.7.10.4

