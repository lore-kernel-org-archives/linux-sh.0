From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Aug 2015 21:37:15 +0000
Subject: [PATCH 1/3] pinctrl: sh-pfc: Remove hardcoded IRQ numbers
Message-Id: <1440797837-25516-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that all ARM-based Renesas SoCs use multiplatform kernels only the
hardcoded IRQ numbers can be dropped as they're dynamically allocated.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 116 +++++++++++++++++------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  68 ++++++++++----------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  68 ++++++++++----------
 drivers/pinctrl/sh-pfc/sh_pfc.h      |   7 +--
 4 files changed, 123 insertions(+), 136 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index ba18d2e65e67..d51d5fd77bbd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -2603,64 +2603,64 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 };
 
 static const struct pinmux_irq pinmux_irqs[] = {
-	PINMUX_IRQ(irq_pin(0), 0),
-	PINMUX_IRQ(irq_pin(1), 1),
-	PINMUX_IRQ(irq_pin(2), 2),
-	PINMUX_IRQ(irq_pin(3), 3),
-	PINMUX_IRQ(irq_pin(4), 4),
-	PINMUX_IRQ(irq_pin(5), 5),
-	PINMUX_IRQ(irq_pin(6), 6),
-	PINMUX_IRQ(irq_pin(7), 7),
-	PINMUX_IRQ(irq_pin(8), 8),
-	PINMUX_IRQ(irq_pin(9), 9),
-	PINMUX_IRQ(irq_pin(10), 10),
-	PINMUX_IRQ(irq_pin(11), 11),
-	PINMUX_IRQ(irq_pin(12), 12),
-	PINMUX_IRQ(irq_pin(13), 13),
-	PINMUX_IRQ(irq_pin(14), 14),
-	PINMUX_IRQ(irq_pin(15), 15),
-	PINMUX_IRQ(irq_pin(16), 320),
-	PINMUX_IRQ(irq_pin(17), 321),
-	PINMUX_IRQ(irq_pin(18), 85),
-	PINMUX_IRQ(irq_pin(19), 84),
-	PINMUX_IRQ(irq_pin(20), 160),
-	PINMUX_IRQ(irq_pin(21), 161),
-	PINMUX_IRQ(irq_pin(22), 162),
-	PINMUX_IRQ(irq_pin(23), 163),
-	PINMUX_IRQ(irq_pin(24), 175),
-	PINMUX_IRQ(irq_pin(25), 176),
-	PINMUX_IRQ(irq_pin(26), 177),
-	PINMUX_IRQ(irq_pin(27), 178),
-	PINMUX_IRQ(irq_pin(28), 322),
-	PINMUX_IRQ(irq_pin(29), 323),
-	PINMUX_IRQ(irq_pin(30), 324),
-	PINMUX_IRQ(irq_pin(31), 192),
-	PINMUX_IRQ(irq_pin(32), 193),
-	PINMUX_IRQ(irq_pin(33), 194),
-	PINMUX_IRQ(irq_pin(34), 195),
-	PINMUX_IRQ(irq_pin(35), 196),
-	PINMUX_IRQ(irq_pin(36), 197),
-	PINMUX_IRQ(irq_pin(37), 198),
-	PINMUX_IRQ(irq_pin(38), 199),
-	PINMUX_IRQ(irq_pin(39), 200),
-	PINMUX_IRQ(irq_pin(40), 66),
-	PINMUX_IRQ(irq_pin(41), 102),
-	PINMUX_IRQ(irq_pin(42), 103),
-	PINMUX_IRQ(irq_pin(43), 109),
-	PINMUX_IRQ(irq_pin(44), 110),
-	PINMUX_IRQ(irq_pin(45), 111),
-	PINMUX_IRQ(irq_pin(46), 112),
-	PINMUX_IRQ(irq_pin(47), 113),
-	PINMUX_IRQ(irq_pin(48), 114),
-	PINMUX_IRQ(irq_pin(49), 115),
-	PINMUX_IRQ(irq_pin(50), 301),
-	PINMUX_IRQ(irq_pin(51), 290),
-	PINMUX_IRQ(irq_pin(52), 296),
-	PINMUX_IRQ(irq_pin(53), 325),
-	PINMUX_IRQ(irq_pin(54), 326),
-	PINMUX_IRQ(irq_pin(55), 327),
-	PINMUX_IRQ(irq_pin(56), 328),
-	PINMUX_IRQ(irq_pin(57), 329),
+	PINMUX_IRQ(0),		/* IRQ0 */
+	PINMUX_IRQ(1),		/* IRQ1 */
+	PINMUX_IRQ(2),		/* IRQ2 */
+	PINMUX_IRQ(3),		/* IRQ3 */
+	PINMUX_IRQ(4),		/* IRQ4 */
+	PINMUX_IRQ(5),		/* IRQ5 */
+	PINMUX_IRQ(6),		/* IRQ6 */
+	PINMUX_IRQ(7),		/* IRQ7 */
+	PINMUX_IRQ(8),		/* IRQ8 */
+	PINMUX_IRQ(9),		/* IRQ9 */
+	PINMUX_IRQ(10),		/* IRQ10 */
+	PINMUX_IRQ(11),		/* IRQ11 */
+	PINMUX_IRQ(12),		/* IRQ12 */
+	PINMUX_IRQ(13),		/* IRQ13 */
+	PINMUX_IRQ(14),		/* IRQ14 */
+	PINMUX_IRQ(15),		/* IRQ15 */
+	PINMUX_IRQ(320),	/* IRQ16 */
+	PINMUX_IRQ(321),	/* IRQ17 */
+	PINMUX_IRQ(85),		/* IRQ18 */
+	PINMUX_IRQ(84),		/* IRQ19 */
+	PINMUX_IRQ(160),	/* IRQ20 */
+	PINMUX_IRQ(161),	/* IRQ21 */
+	PINMUX_IRQ(162),	/* IRQ22 */
+	PINMUX_IRQ(163),	/* IRQ23 */
+	PINMUX_IRQ(175),	/* IRQ24 */
+	PINMUX_IRQ(176),	/* IRQ25 */
+	PINMUX_IRQ(177),	/* IRQ26 */
+	PINMUX_IRQ(178),	/* IRQ27 */
+	PINMUX_IRQ(322),	/* IRQ28 */
+	PINMUX_IRQ(323),	/* IRQ29 */
+	PINMUX_IRQ(324),	/* IRQ30 */
+	PINMUX_IRQ(192),	/* IRQ31 */
+	PINMUX_IRQ(193),	/* IRQ32 */
+	PINMUX_IRQ(194),	/* IRQ33 */
+	PINMUX_IRQ(195),	/* IRQ34 */
+	PINMUX_IRQ(196),	/* IRQ35 */
+	PINMUX_IRQ(197),	/* IRQ36 */
+	PINMUX_IRQ(198),	/* IRQ37 */
+	PINMUX_IRQ(199),	/* IRQ38 */
+	PINMUX_IRQ(200),	/* IRQ39 */
+	PINMUX_IRQ(66),		/* IRQ40 */
+	PINMUX_IRQ(102),	/* IRQ41 */
+	PINMUX_IRQ(103),	/* IRQ42 */
+	PINMUX_IRQ(109),	/* IRQ43 */
+	PINMUX_IRQ(110),	/* IRQ44 */
+	PINMUX_IRQ(111),	/* IRQ45 */
+	PINMUX_IRQ(112),	/* IRQ46 */
+	PINMUX_IRQ(113),	/* IRQ47 */
+	PINMUX_IRQ(114),	/* IRQ48 */
+	PINMUX_IRQ(115),	/* IRQ49 */
+	PINMUX_IRQ(301),	/* IRQ50 */
+	PINMUX_IRQ(290),	/* IRQ51 */
+	PINMUX_IRQ(296),	/* IRQ52 */
+	PINMUX_IRQ(325),	/* IRQ53 */
+	PINMUX_IRQ(326),	/* IRQ54 */
+	PINMUX_IRQ(327),	/* IRQ55 */
+	PINMUX_IRQ(328),	/* IRQ56 */
+	PINMUX_IRQ(329),	/* IRQ57 */
 };
 
 #define PORTCR_PULMD_OFF (0 << 6)
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index d0bb1459783a..44223b3df352 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -22,10 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
-#ifndef CONFIG_ARCH_MULTIPLATFORM
-#include <mach/irqs.h>
-#endif
-
 #include "core.h"
 #include "sh_pfc.h"
 
@@ -3655,38 +3651,38 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 };
 
 static const struct pinmux_irq pinmux_irqs[] = {
-	PINMUX_IRQ(irq_pin(0), 2,   13),	/* IRQ0A */
-	PINMUX_IRQ(irq_pin(1), 20),		/* IRQ1A */
-	PINMUX_IRQ(irq_pin(2), 11,  12),	/* IRQ2A */
-	PINMUX_IRQ(irq_pin(3), 10,  14),	/* IRQ3A */
-	PINMUX_IRQ(irq_pin(4), 15,  172),	/* IRQ4A */
-	PINMUX_IRQ(irq_pin(5), 0,   1),		/* IRQ5A */
-	PINMUX_IRQ(irq_pin(6), 121, 173),	/* IRQ6A */
-	PINMUX_IRQ(irq_pin(7), 120, 209),	/* IRQ7A */
-	PINMUX_IRQ(irq_pin(8), 119),		/* IRQ8A */
-	PINMUX_IRQ(irq_pin(9), 118, 210),	/* IRQ9A */
-	PINMUX_IRQ(irq_pin(10), 19),		/* IRQ10A */
-	PINMUX_IRQ(irq_pin(11), 104),		/* IRQ11A */
-	PINMUX_IRQ(irq_pin(12), 42,  97),	/* IRQ12A */
-	PINMUX_IRQ(irq_pin(13), 64,  98),	/* IRQ13A */
-	PINMUX_IRQ(irq_pin(14), 63,  99),	/* IRQ14A */
-	PINMUX_IRQ(irq_pin(15), 62,  100),	/* IRQ15A */
-	PINMUX_IRQ(irq_pin(16), 68,  211),	/* IRQ16A */
-	PINMUX_IRQ(irq_pin(17), 69),		/* IRQ17A */
-	PINMUX_IRQ(irq_pin(18), 70),		/* IRQ18A */
-	PINMUX_IRQ(irq_pin(19), 71),		/* IRQ19A */
-	PINMUX_IRQ(irq_pin(20), 67),		/* IRQ20A */
-	PINMUX_IRQ(irq_pin(21), 202),		/* IRQ21A */
-	PINMUX_IRQ(irq_pin(22), 95),		/* IRQ22A */
-	PINMUX_IRQ(irq_pin(23), 96),		/* IRQ23A */
-	PINMUX_IRQ(irq_pin(24), 180),		/* IRQ24A */
-	PINMUX_IRQ(irq_pin(25), 38),		/* IRQ25A */
-	PINMUX_IRQ(irq_pin(26), 58,  81),	/* IRQ26A */
-	PINMUX_IRQ(irq_pin(27), 57,  168),	/* IRQ27A */
-	PINMUX_IRQ(irq_pin(28), 56,  169),	/* IRQ28A */
-	PINMUX_IRQ(irq_pin(29), 50,  170),	/* IRQ29A */
-	PINMUX_IRQ(irq_pin(30), 49,  171),	/* IRQ30A */
-	PINMUX_IRQ(irq_pin(31), 41,  167),	/* IRQ31A */
+	PINMUX_IRQ(2,   13),	/* IRQ0A */
+	PINMUX_IRQ(20),		/* IRQ1A */
+	PINMUX_IRQ(11,  12),	/* IRQ2A */
+	PINMUX_IRQ(10,  14),	/* IRQ3A */
+	PINMUX_IRQ(15,  172),	/* IRQ4A */
+	PINMUX_IRQ(0,   1),	/* IRQ5A */
+	PINMUX_IRQ(121, 173),	/* IRQ6A */
+	PINMUX_IRQ(120, 209),	/* IRQ7A */
+	PINMUX_IRQ(119),	/* IRQ8A */
+	PINMUX_IRQ(118, 210),	/* IRQ9A */
+	PINMUX_IRQ(19),		/* IRQ10A */
+	PINMUX_IRQ(104),	/* IRQ11A */
+	PINMUX_IRQ(42,  97),	/* IRQ12A */
+	PINMUX_IRQ(64,  98),	/* IRQ13A */
+	PINMUX_IRQ(63,  99),	/* IRQ14A */
+	PINMUX_IRQ(62,  100),	/* IRQ15A */
+	PINMUX_IRQ(68,  211),	/* IRQ16A */
+	PINMUX_IRQ(69),		/* IRQ17A */
+	PINMUX_IRQ(70),		/* IRQ18A */
+	PINMUX_IRQ(71),		/* IRQ19A */
+	PINMUX_IRQ(67),		/* IRQ20A */
+	PINMUX_IRQ(202),	/* IRQ21A */
+	PINMUX_IRQ(95),		/* IRQ22A */
+	PINMUX_IRQ(96),		/* IRQ23A */
+	PINMUX_IRQ(180),	/* IRQ24A */
+	PINMUX_IRQ(38),		/* IRQ25A */
+	PINMUX_IRQ(58,  81),	/* IRQ26A */
+	PINMUX_IRQ(57,  168),	/* IRQ27A */
+	PINMUX_IRQ(56,  169),	/* IRQ28A */
+	PINMUX_IRQ(50,  170),	/* IRQ29A */
+	PINMUX_IRQ(49,  171),	/* IRQ30A */
+	PINMUX_IRQ(41,  167),	/* IRQ31A */
 };
 
 #define PORTnCR_PULMD_OFF	(0 << 6)
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index d2efbfb776ac..bec265245ad9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -26,10 +26,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
 
-#ifndef CONFIG_ARCH_MULTIPLATFORM
-#include <mach/irqs.h>
-#endif
-
 #include "core.h"
 #include "sh_pfc.h"
 
@@ -3653,38 +3649,38 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 };
 
 static const struct pinmux_irq pinmux_irqs[] = {
-	PINMUX_IRQ(irq_pin(0), 11),
-	PINMUX_IRQ(irq_pin(1), 10),
-	PINMUX_IRQ(irq_pin(2), 149),
-	PINMUX_IRQ(irq_pin(3), 224),
-	PINMUX_IRQ(irq_pin(4), 159),
-	PINMUX_IRQ(irq_pin(5), 227),
-	PINMUX_IRQ(irq_pin(6), 147),
-	PINMUX_IRQ(irq_pin(7), 150),
-	PINMUX_IRQ(irq_pin(8), 223),
-	PINMUX_IRQ(irq_pin(9), 56, 308),
-	PINMUX_IRQ(irq_pin(10), 54),
-	PINMUX_IRQ(irq_pin(11), 238),
-	PINMUX_IRQ(irq_pin(12), 156),
-	PINMUX_IRQ(irq_pin(13), 239),
-	PINMUX_IRQ(irq_pin(14), 251),
-	PINMUX_IRQ(irq_pin(15), 0),
-	PINMUX_IRQ(irq_pin(16), 249),
-	PINMUX_IRQ(irq_pin(17), 234),
-	PINMUX_IRQ(irq_pin(18), 13),
-	PINMUX_IRQ(irq_pin(19), 9),
-	PINMUX_IRQ(irq_pin(20), 14),
-	PINMUX_IRQ(irq_pin(21), 15),
-	PINMUX_IRQ(irq_pin(22), 40),
-	PINMUX_IRQ(irq_pin(23), 53),
-	PINMUX_IRQ(irq_pin(24), 118),
-	PINMUX_IRQ(irq_pin(25), 164),
-	PINMUX_IRQ(irq_pin(26), 115),
-	PINMUX_IRQ(irq_pin(27), 116),
-	PINMUX_IRQ(irq_pin(28), 117),
-	PINMUX_IRQ(irq_pin(29), 28),
-	PINMUX_IRQ(irq_pin(30), 27),
-	PINMUX_IRQ(irq_pin(31), 26),
+	PINMUX_IRQ(11),		/* IRQ0 */
+	PINMUX_IRQ(10),		/* IRQ1 */
+	PINMUX_IRQ(149),	/* IRQ2 */
+	PINMUX_IRQ(224),	/* IRQ3 */
+	PINMUX_IRQ(159),	/* IRQ4 */
+	PINMUX_IRQ(227),	/* IRQ5 */
+	PINMUX_IRQ(147),	/* IRQ6 */
+	PINMUX_IRQ(150),	/* IRQ7 */
+	PINMUX_IRQ(223),	/* IRQ8 */
+	PINMUX_IRQ(56, 308),	/* IRQ9 */
+	PINMUX_IRQ(54),		/* IRQ10 */
+	PINMUX_IRQ(238),	/* IRQ11 */
+	PINMUX_IRQ(156),	/* IRQ12 */
+	PINMUX_IRQ(239),	/* IRQ13 */
+	PINMUX_IRQ(251),	/* IRQ14 */
+	PINMUX_IRQ(0),		/* IRQ15 */
+	PINMUX_IRQ(249),	/* IRQ16 */
+	PINMUX_IRQ(234),	/* IRQ17 */
+	PINMUX_IRQ(13),		/* IRQ18 */
+	PINMUX_IRQ(9),		/* IRQ19 */
+	PINMUX_IRQ(14),		/* IRQ20 */
+	PINMUX_IRQ(15),		/* IRQ21 */
+	PINMUX_IRQ(40),		/* IRQ22 */
+	PINMUX_IRQ(53),		/* IRQ23 */
+	PINMUX_IRQ(118),	/* IRQ24 */
+	PINMUX_IRQ(164),	/* IRQ25 */
+	PINMUX_IRQ(115),	/* IRQ26 */
+	PINMUX_IRQ(116),	/* IRQ27 */
+	PINMUX_IRQ(117),	/* IRQ28 */
+	PINMUX_IRQ(28),		/* IRQ29 */
+	PINMUX_IRQ(27),		/* IRQ30 */
+	PINMUX_IRQ(26),		/* IRQ31 */
 };
 
 /* -----------------------------------------------------------------------------
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 1f43bae56065..4706c8cc54b8 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -100,13 +100,8 @@ struct pinmux_irq {
 	const short *gpios;
 };
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
-#define PINMUX_IRQ(irq_nr, ids...)			   \
+#define PINMUX_IRQ(ids...)			   \
 	{ .gpios = (const short []) { ids, -1 } }
-#else
-#define PINMUX_IRQ(irq_nr, ids...)			   \
-	{ .irq = irq_nr, .gpios = (const short []) { ids, -1 } }
-#endif
 
 struct pinmux_range {
 	u16 begin;
-- 
2.4.6

