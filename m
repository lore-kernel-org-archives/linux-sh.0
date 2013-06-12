From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 12 Jun 2013 02:03:59 +0000
Subject: [PATCH resend] ARM: shmobile: r8a7790: add __initdata on resource and device data
Message-Id: <87ehc86q5v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These data will be kmemdup()'ed on
platform_device_add_resources() and platform_device_add_data()
This patch removed "const" to avoid section type conflict
with r8a7790_boards_compat_dt

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

I couldn't find this patch on Simon's tree.
This patch is resend patch, and is based on renesas-next-20130611v2

 arch/arm/mach-shmobile/setup-r8a7790.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 75950c3..28f9475 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -30,17 +30,17 @@
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
-static const struct resource pfc_resources[] = {
+static struct resource pfc_resources[] __initdata = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
 };
 
 #define R8A7790_GPIO(idx)						\
-static struct resource r8a7790_gpio##idx##_resources[] = {		\
+static struct resource r8a7790_gpio##idx##_resources[] __initdata = {	\
 	DEFINE_RES_MEM(0xe6050000 + 0x1000 * (idx), 0x50),		\
 	DEFINE_RES_IRQ(gic_spi(4 + (idx))),				\
 };									\
 									\
-static struct gpio_rcar_config r8a7790_gpio##idx##_platform_data = {	\
+static struct gpio_rcar_config r8a7790_gpio##idx##_platform_data __initdata = {	\
 	.gpio_base	= 32 * (idx),					\
 	.irq_base	= 0,						\
 	.number_of_pins	= 32,						\
@@ -111,7 +111,7 @@ void __init r8a7790_pinmux_init(void)
 enum { SCIFA0, SCIFA1, SCIFB0, SCIFB1, SCIFB2, SCIFA2, SCIF0, SCIF1,
        HSCIF0, HSCIF1 };
 
-static const struct plat_sci_port scif[] = {
+static struct plat_sci_port scif[] __initdata = {
 	SCIFA_DATA(SCIFA0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
 	SCIFA_DATA(SCIFA1, 0xe6c50000, gic_spi(145)), /* SCIFA1 */
 	SCIFB_DATA(SCIFB0, 0xe6c20000, gic_spi(148)), /* SCIFB0 */
@@ -130,11 +130,11 @@ static inline void r8a7790_register_scif(int idx)
 				      sizeof(struct plat_sci_port));
 }
 
-static struct renesas_irqc_config irqc0_data = {
+static struct renesas_irqc_config irqc0_data __initdata = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
 };
 
-static struct resource irqc0_resources[] = {
+static struct resource irqc0_resources[] __initdata = {
 	DEFINE_RES_MEM(0xe61c0000, 0x200), /* IRQC Event Detector Block_0 */
 	DEFINE_RES_IRQ(gic_spi(0)), /* IRQ0 */
 	DEFINE_RES_IRQ(gic_spi(1)), /* IRQ1 */
-- 
1.7.9.5

