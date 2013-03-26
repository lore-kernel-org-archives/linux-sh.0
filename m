From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Mar 2013 13:49:59 +0000
Subject: [PATCH 02/13] sh-pfc: r8a73a4: Support sparse GPIO numbers
Message-Id: <20130326134959.31366.93833.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The r8a73a4 SoC has sparse GPIO numbers. Declare ranges for
pin numbers in the PFC SoC data. Pin numbers shall be used
with the GPIO API from this point on.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

--- 0007/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h	2013-03-26 20:20:54.000000000 +0900
@@ -86,7 +86,7 @@ enum {
 	GPIO_PORT325, GPIO_PORT326, GPIO_PORT327, GPIO_PORT328, GPIO_PORT329,
 
 	/* Port0 */
-	GPIO_FN_LCDD0,
+	GPIO_FN_LCDD0 = 330,
 	GPIO_FN_PDM2_CLK_0,
 	GPIO_FN_DU0_DR0,
 	GPIO_FN_IRQ0,
--- 0007/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c	2013-03-26 21:12:07.000000000 +0900
@@ -1424,6 +1424,20 @@ static struct sh_pfc_pin pinmux_pins[]  	GPIO_PORT_ALL(),
 };
 
+static const struct pinmux_range pinmux_ranges[] = {
+	{.begin = 0, .end = 30,},
+	{.begin = 32, .end = 40,},
+	{.begin = 64, .end = 85,},
+	{.begin = 96, .end = 126,},
+	{.begin = 128, .end = 134,},
+	{.begin = 160, .end = 178,},
+	{.begin = 192, .end = 222,},
+	{.begin = 224, .end = 250,},
+	{.begin = 256, .end = 283,},
+	{.begin = 288, .end = 308,},
+	{.begin = 320, .end = 329,},
+};
+
 #define PINMUX_FN_BASE	ARRAY_SIZE(pinmux_pins)
 
 static const struct pinmux_func pinmux_func_gpios[] = {
@@ -2815,6 +2829,8 @@ const struct sh_pfc_soc_info r8a73a4_pin
 
 	.pins = pinmux_pins,
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.ranges = pinmux_ranges,
+	.nr_ranges = ARRAY_SIZE(pinmux_ranges),
 	.func_gpios = pinmux_func_gpios,
 	.nr_func_gpios = ARRAY_SIZE(pinmux_func_gpios),
 
