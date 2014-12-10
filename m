From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 10 Dec 2014 14:45:23 +0000
Subject: [PATCH v7 2/6] ARM: shmobile: sh73a0: Add CPG register bits header
Message-Id: <1418222727-19888-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/dt-bindings/clock/sh73a0-clock.h | 79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 include/dt-bindings/clock/sh73a0-clock.h

diff --git a/include/dt-bindings/clock/sh73a0-clock.h b/include/dt-bindings/clock/sh73a0-clock.h
new file mode 100644
index 0000000..1dd3eb2
--- /dev/null
+++ b/include/dt-bindings/clock/sh73a0-clock.h
@@ -0,0 +1,79 @@
+/*
+ * Copyright 2014 Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SH73A0_H__
+#define __DT_BINDINGS_CLOCK_SH73A0_H__
+
+/* CPG */
+#define SH73A0_CLK_MAIN		0
+#define SH73A0_CLK_PLL0		1
+#define SH73A0_CLK_PLL1		2
+#define SH73A0_CLK_PLL2		3
+#define SH73A0_CLK_PLL3		4
+#define SH73A0_CLK_DSI0PHY	5
+#define SH73A0_CLK_DSI1PHY	6
+#define SH73A0_CLK_ZG		7
+#define SH73A0_CLK_M3		8
+#define SH73A0_CLK_B		9
+#define SH73A0_CLK_M1		10
+#define SH73A0_CLK_M2		11
+#define SH73A0_CLK_Z		12
+#define SH73A0_CLK_ZX		13
+#define SH73A0_CLK_HP		14
+
+/* MSTP0 */
+#define SH73A0_CLK_IIC2	1
+
+/* MSTP1 */
+#define SH73A0_CLK_CEU1		29
+#define SH73A0_CLK_CSI2_RX1	28
+#define SH73A0_CLK_CEU0		27
+#define SH73A0_CLK_CSI2_RX0	26
+#define SH73A0_CLK_TMU0		25
+#define SH73A0_CLK_DSITX0	18
+#define SH73A0_CLK_IIC0		16
+#define SH73A0_CLK_SGX		12
+#define SH73A0_CLK_LCDC0	0
+
+/* MSTP2 */
+#define SH73A0_CLK_SCIFA7	19
+#define SH73A0_CLK_SY_DMAC	18
+#define SH73A0_CLK_MP_DMAC	17
+#define SH73A0_CLK_SCIFA5	7
+#define SH73A0_CLK_SCIFB	6
+#define SH73A0_CLK_SCIFA0	4
+#define SH73A0_CLK_SCIFA1	3
+#define SH73A0_CLK_SCIFA2	2
+#define SH73A0_CLK_SCIFA3	1
+#define SH73A0_CLK_SCIFA4	0
+
+/* MSTP3 */
+#define SH73A0_CLK_SCIFA6	31
+#define SH73A0_CLK_CMT1		29
+#define SH73A0_CLK_FSI		28
+#define SH73A0_CLK_IRDA		25
+#define SH73A0_CLK_IIC1		23
+#define SH73A0_CLK_USB		22
+#define SH73A0_CLK_FLCTL	15
+#define SH73A0_CLK_SDHI0	14
+#define SH73A0_CLK_SDHI1	13
+#define SH73A0_CLK_MMCIF0	12
+#define SH73A0_CLK_SDHI2	11
+#define SH73A0_CLK_TPU0		4
+#define SH73A0_CLK_TPU1		3
+#define SH73A0_CLK_TPU2		2
+#define SH73A0_CLK_TPU3		1
+#define SH73A0_CLK_TPU4		0
+
+/* MSTP4 */
+#define SH73A0_CLK_IIC3		11
+#define SH73A0_CLK_IIC4		10
+#define SH73A0_CLK_KEYSC	3
+
+#endif
-- 
1.8.4.5

