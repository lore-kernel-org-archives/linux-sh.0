From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 01 Mar 2012 09:48:35 +0000
Subject: [PATCH v3 1/7] mtd: sh_flctl: Expand FLCMNCR register bit field
Message-Id: <1330595321-2728-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pichart <laurent.pinchart@ideasonboard.com>

Add support for a new hardware generation. The meaning of some bits
of the FLCMNCR register changed, so some new defines are added
parallel to the existing ones to keep backward compatibility.

The defines allow to choose an appropriate clocking scheme.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
changelog: shortened the names of some defines.

 include/linux/mtd/sh_flctl.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 9cf4c4c..b669405 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -67,6 +67,30 @@
 #define	CE0_ENABLE	(0x1 << 3)	/* Chip Enable 0 */
 #define	TYPESEL_SET	(0x1 << 0)
 
+/*
+ * Clock settings using the PULSEx registers from FLCMNCR
+ *
+ * Some hardware uses bits called PULSEx instead of FCKSEL_E and QTSEL_E
+ * to control the clock divider used between the High-Speed Peripheral Clock
+ * and the FLCTL internal clock. If so, use CLK_8_BIT_xxx for connecting 8 bit
+ * and CLK_16_BIT_xxx for connecting 16 bit bus bandwith NAND chips. For the 16
+ * bit version the divider is seperate for the pulse width of high and low
+ * signals.
+ */
+#define PULSE3	(0x1 << 27)
+#define PULSE2	(0x1 << 17)
+#define PULSE1	(0x1 << 15)
+#define PULSE0	(0x1 << 9)
+#define CLK_8B_0_5			PULSE1
+#define CLK_8B_1			0x0
+#define CLK_8B_1_5			(PULSE1 | PULSE2)
+#define CLK_8B_2			PULSE0
+#define CLK_8B_3			(PULSE0 | PULSE1 | PULSE2)
+#define CLK_8B_4			(PULSE0 | PULSE2)
+#define CLK_16B_6L_2H			PULSE0
+#define CLK_16B_9L_3H			(PULSE0 | PULSE1 | PULSE2)
+#define CLK_16B_12L_4H			(PULSE0 | PULSE2)
+
 /* FLCMDCR control bits */
 #define ADRCNT2_E	(0x1 << 31)	/* 5byte address enable */
 #define ADRMD_E		(0x1 << 26)	/* Sector address access */
-- 
1.7.5.4

