From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Nov 2013 01:18:18 +0000
Subject: [RFC 03/17] ARM: shmobile: r8a7779: Add clock index macros for DT sources
Message-Id: <1385342312-1967-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add macros usable by device tree sources to reference r8a7779 clocks by index.

Based on work for the r8a7790 and r8a7791 SoCs by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r8a7779-clock.h | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7779-clock.h

diff --git a/include/dt-bindings/clock/r8a7779-clock.h b/include/dt-bindings/clock/r8a7779-clock.h
new file mode 100644
index 0000000..b05fa8b
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7779-clock.h
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2013  Horms Solutions Ltd.
+ *
+ * Contact: Simon Horman <horms@verge.net.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7779_H__
+#define __DT_BINDINGS_CLOCK_R8A7779_H__
+
+/* CPG */
+#define R8A7779_CLK_PLLA	0
+#define R8A7779_CLK_Z		1
+#define R8A7779_CLK_ZS		2
+#define R8A7779_CLK_S		3
+#define R8A7779_CLK_S1		4
+#define R8A7779_CLK_P		5
+#define R8A7779_CLK_OUT		6
+
+/* MSTP 0 */
+#define R8A7779_CLK_HSPI0	7
+#define R8A7779_CLK_HSPI1	7
+#define R8A7779_CLK_HSPI2	7
+#define R8A7779_CLK_TMU0	16
+#define R8A7779_CLK_TMU1	16
+#define R8A7779_CLK_TMU2	16
+#define R8A7779_CLK_SCIF6	21
+#define R8A7779_CLK_SCIF4	22
+#define R8A7779_CLK_SCIF3	23
+#define R8A7779_CLK_SCIF2	24
+#define R8A7779_CLK_SCIF1	25
+#define R8A7779_CLK_SCIF0	26
+#define R8A7779_CLK_I2C3	27
+#define R8A7779_CLK_I2C2	28
+#define R8A7779_CLK_I2C1	29
+#define R8A7779_CLK_I2C0	30
+
+/* MSTP 1 */
+#define R8A7779_CLK_EHCI0	0
+#define R8A7779_CLK_OHCI0	0
+#define R8A7779_CLK_EHCI1	1
+#define R8A7779_CLK_OHCI1	1
+#define R8A7779_CLK_DU		3
+#define R8A7779_CLK_VIN2	8
+#define R8A7779_CLK_VIN1	9
+#define R8A7779_CLK_VIN0	10
+#define R8A7779_CLK_SATA	15
+#define R8A7779_CLK_VIN3	20
+
+/* MSTP 3 */
+#define R8A7779_CLK_SDHI3	20
+#define R8A7779_CLK_SDHI2	21
+#define R8A7779_CLK_SDHI1	22
+#define R8A7779_CLK_SDHI0	23
+
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7779_H__ */
-- 
1.8.4

