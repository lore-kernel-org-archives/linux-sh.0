From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 21 Jan 2015 16:20:53 +0000
Subject: [PATCH 02/11] ARM: shmobile: r8a7778: add CPG register bits header
Message-Id: <1421857262-16607-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enumerates CPG driver custom clocks and MSTP clock enable bits.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 include/dt-bindings/clock/r8a7778-clock.h | 72 +++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7778-clock.h

diff --git a/include/dt-bindings/clock/r8a7778-clock.h b/include/dt-bindings/clock/r8a7778-clock.h
new file mode 100644
index 0000000..6c5f3d9
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7778-clock.h
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2014 Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7778_H__
+#define __DT_BINDINGS_CLOCK_R8A7778_H__
+
+/* CPG */
+#define R8A7778_CLK_EXTAL	0
+#define R8A7778_CLK_PLLA	1
+#define R8A7778_CLK_PLLB	2
+#define R8A7778_CLK_B		3
+#define R8A7778_CLK_OUT		4
+#define R8A7778_CLK_P		5
+#define R8A7778_CLK_S		6
+#define R8A7778_CLK_S1		7
+
+/* MSTP0 */
+#define R8A7778_CLK_I2C0	30
+#define R8A7778_CLK_I2C1	29
+#define R8A7778_CLK_I2C2	28
+#define R8A7778_CLK_I2C3	27
+#define R8A7778_CLK_SCIF0	26
+#define R8A7778_CLK_SCIF1	25
+#define R8A7778_CLK_SCIF2	24
+#define R8A7778_CLK_SCIF3	23
+#define R8A7778_CLK_SCIF4	22
+#define R8A7778_CLK_SCIF5	21
+#define R8A7778_CLK_TMU0	16
+#define R8A7778_CLK_TMU1	15
+#define R8A7778_CLK_TMU2	14
+#define R8A7778_CLK_SSI0	12
+#define R8A7778_CLK_SSI1	11
+#define R8A7778_CLK_SSI2	10
+#define R8A7778_CLK_SSI3	9
+#define R8A7778_CLK_SRU		8
+#define R8A7778_CLK_HSPI	7
+
+/* MSTP1 */
+#define R8A7778_CLK_ETHER	14
+#define R8A7778_CLK_VIN0	10
+#define R8A7778_CLK_VIN1	9
+#define R8A7778_CLK_USB		0
+
+/* MSTP3 */
+#define R8A7778_CLK_MMC		31
+#define R8A7778_CLK_SDHI0	23
+#define R8A7778_CLK_SDHI1	22
+#define R8A7778_CLK_SDHI2	21
+#define R8A7778_CLK_SSI4	11
+#define R8A7778_CLK_SSI5	10
+#define R8A7778_CLK_SSI6	9
+#define R8A7778_CLK_SSI7	8
+#define R8A7778_CLK_SSI8	7
+
+/* MSTP5 */
+#define R8A7778_CLK_SCU0	31
+#define R8A7778_CLK_SCU1	30
+#define R8A7778_CLK_SCU2	29
+#define R8A7778_CLK_SCU3	28
+#define R8A7778_CLK_SCU4	27
+#define R8A7778_CLK_SCU5	26
+#define R8A7778_CLK_SCU6	25
+#define R8A7778_CLK_SCU7	24
+#define R8A7778_CLK_SCU8	23
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7778_H__ */
-- 
2.2.2

