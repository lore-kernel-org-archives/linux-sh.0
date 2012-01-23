From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 23 Jan 2012 14:52:03 +0000
Subject: [PATCH] ARM: mach-shmobile: add GPIO-to-IRQ translation to sh7372
Message-Id: <Pine.LNX.4.64.1201231549470.11184@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This table is required to support the gpio_to_irq() translation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Please, review. I don't think I can say much about the correctness of this 
patch apart from, that it works for my specific case:-)

 arch/arm/mach-shmobile/pfc-sh7372.c |   41 +++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index 1bd6585..336093f9 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <mach/irqs.h>
 #include <mach/sh7372.h>
 
 #define CPU_ALL_PORT(fn, pfx, sfx) \
@@ -1594,6 +1595,43 @@ static struct pinmux_data_reg pinmux_data_regs[] = {
 	{ },
 };
 
+#define EXT_IRQ16L(n) evt2irq(0x200 + ((n) << 5))
+#define EXT_IRQ16H(n) evt2irq(0x3200 + (((n) - 16) << 5))
+static struct pinmux_irq pinmux_irqs[] = {
+	PINMUX_IRQ(EXT_IRQ16L(0), PORT6_FN0, PORT162_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(1), PORT12_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(2), PORT4_FN0, PORT5_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(3), PORT8_FN0, PORT16_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(4), PORT17_FN0, PORT163_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(5), PORT18_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(6), PORT39_FN0, PORT164_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(7), PORT40_FN0, PORT167_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(8), PORT41_FN0, PORT168_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(9), PORT42_FN0, PORT169_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(10), PORT65_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(11), PORT67_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(12), PORT80_FN0, PORT137_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(13), PORT81_FN0, PORT145_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(14), PORT82_FN0, PORT146_FN0),
+	PINMUX_IRQ(EXT_IRQ16L(15), PORT83_FN0, PORT147_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(16), PORT84_FN0, PORT170_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(17), PORT85_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(18), PORT86_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(19), PORT87_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(20), PORT92_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(21), PORT93_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(22), PORT94_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(23), PORT95_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(24), PORT112_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(25), PORT119_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(26), PORT121_FN0, PORT172_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(27), PORT122_FN0, PORT180_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(28), PORT123_FN0, PORT181_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(29), PORT129_FN0, PORT182_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(30), PORT130_FN0, PORT183_FN0),
+	PINMUX_IRQ(EXT_IRQ16H(31), PORT138_FN0, PORT184_FN0),
+};
+
 static struct pinmux_info sh7372_pinmux_info = {
 	.name = "sh7372_pfc",
 	.reserved_id = PINMUX_RESERVED,
@@ -1614,6 +1652,9 @@ static struct pinmux_info sh7372_pinmux_info = {
 
 	.gpio_data = pinmux_data,
 	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+
+	.gpio_irq = pinmux_irqs,
+	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
 
 void sh7372_pinmux_init(void)
-- 
1.7.2.5

