From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Jun 2009 08:27:27 +0000
Subject: [PATCH] sh: sh7723 mode pin definitions
Message-Id: <20090602082727.26640.94726.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds sh7723 mode pin definitions. Mode pins and
pin function controller comments are added as well.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

--- 0001/arch/sh/include/cpu-sh4/cpu/sh7723.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7723.h	2009-06-02 15:19:42.000000000 +0900
@@ -1,6 +1,21 @@
 #ifndef __ASM_SH7723_H__
 #define __ASM_SH7723_H__
 
+/* Boot Mode Pins */
+enum {
+	MODE_PIN_MD0,  /* CPG - Clock Mode 0->3 */
+	MODE_PIN_MD1,  /* CPG - Clock Mode 0->3 */
+	MODE_PIN_MD2,  /* CPG - Reserved (L: Normal operation) */
+	MODE_PIN_MD3,  /* BSC - Area0 Bus Width (16/32-bit) [CS0BCR.9,10] */
+	MODE_PIN_MD5 = 5,  /* BSC - Endian Mode (L: Big, H: Little) [CMNCR.3]*/
+	MODE_PIN_MD8 = 8,  /* Test Mode (?) */
+	MODE_PIN_TSTMD, /* Test Mode (H: Normal operation) */
+};
+
+/* Pin Function Controller:
+ * GPIO_FN_xx - GPIO used to select pin function
+ * GPIO_Pxx - GPIO mapped to real I/O pin on CPU
+ */
 enum {
 	/* PTA */
 	GPIO_PTA7, GPIO_PTA6, GPIO_PTA5, GPIO_PTA4,
