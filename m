From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 09 Feb 2015 16:02:30 +0000
Subject: [PATCH v2 02/15] ARM: shmobile: r8a7778: add CPG register bits header
Message-Id: <1423497763-3450-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enumerates CPG driver custom clocks and MSTP clock enable bits.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/dt-bindings/clock/r8a7778-clock.h | 71 +++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7778-clock.h

diff --git a/include/dt-bindings/clock/r8a7778-clock.h b/include/dt-bindings/clock/r8a7778-clock.h
new file mode 100644
index 0000000..fdb1898
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7778-clock.h
@@ -0,0 +1,71 @@
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
+#define R8A7778_CLK_PLLA	0
+#define R8A7778_CLK_PLLB	1
+#define R8A7778_CLK_B		2
+#define R8A7778_CLK_OUT		3
+#define R8A7778_CLK_P		4
+#define R8A7778_CLK_S		5
+#define R8A7778_CLK_S1		6
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
+#define R8A7778_CLK_SCU_SRC0	31
+#define R8A7778_CLK_SCU_SRC1	30
+#define R8A7778_CLK_SCU_SRC2	29
+#define R8A7778_CLK_SCU_SRC3	28
+#define R8A7778_CLK_SCU_SRC4	27
+#define R8A7778_CLK_SCU_SRC5	26
+#define R8A7778_CLK_SCU_SRC6	25
+#define R8A7778_CLK_SCU_SRC7	24
+#define R8A7778_CLK_SCU_SRC8	23
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7778_H__ */
-- 
2.2.2

