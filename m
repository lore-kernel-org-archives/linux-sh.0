From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 11:56:21 +0000
Subject: [PATCH] sh: sh7785 mode pin definitions
Message-Id: <20090528115621.5770.60114.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds sh7785 mode pin definitions. Mode pins and
pin function controller comments are added as well.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/cpu-sh4/cpu/sh7785.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- 0001/arch/sh/include/cpu-sh4/cpu/sh7785.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7785.h	2009-05-28 20:42:21.000000000 +0900
@@ -1,6 +1,28 @@
 #ifndef __ASM_SH7785_H__
 #define __ASM_SH7785_H__
 
+/* Boot Mode Pins, more information in sh7785 manual Rev.1.00, page 1628 */
+#define MODE_PIN_MODE0 0 /* CPG - Initial Pck/Bck Frequency [FRQMR1] */
+#define MODE_PIN_MODE1 1 /* CPG - Initial Uck/SHck/DDRck Frequency [FRQMR1] */
+#define MODE_PIN_MODE2 2 /* CPG - Reserved (L: Normal operation) */
+#define MODE_PIN_MODE3 3 /* CPG - Reserved (L: Normal operation) */
+#define MODE_PIN_MODE4 4 /* CPG - Initial PLL setting (72x/36x) */
+#define MODE_PIN_MODE5 5 /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.8] */
+#define MODE_PIN_MODE6 6 /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.9] */
+#define MODE_PIN_MODE7 7 /* LBSC - Area0 Memory Type / Bus Width [CS0BCR.3] */
+#define MODE_PIN_MODE8 8 /* LBSC - Endian Mode (L: Big, H: Little) [BCR.31] */
+#define MODE_PIN_MODE9 9 /* LBSC - Master/Slave Mode (L: Slave) [BCR.30] */
+#define MODE_PIN_MODE10 10 /* CPG - Clock Input (L: Ext Clk, H: Crystal) */
+#define MODE_PIN_MODE11 11 /* PCI - Pin Mode (LL: PCI host, LH: PCI slave) */
+#define MODE_PIN_MODE12 12 /* PCI - Pin Mode (HL: Local bus, HH: DU) */
+#define MODE_PIN_MODE13 13 /* Boot Address Mode (L: 29-bit, H: 32-bit) */
+#define MODE_PIN_MODE14 14 /* Reserved (H: Normal operation) */
+#define MODE_PIN_MPMD 15 /* Emulation Mode (L: Emulation mode, H: LSI mode) */
+
+/* Pin Function Controller:
+ * GPIO_FN_xx - GPIO used to select pin function
+ * GPIO_Pxx - GPIO mapped to real I/O pin on CPU
+ */
 enum {
 	/* PA */
 	GPIO_PA7, GPIO_PA6, GPIO_PA5, GPIO_PA4,
