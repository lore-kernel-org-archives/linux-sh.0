From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Jun 2009 08:18:56 +0000
Subject: [PATCH] sh: sh7722 mode pin definitions
Message-Id: <20090603081856.28322.87630.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds sh7722 mode pin and pin function
controller comments.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/cpu-sh4/cpu/sh7722.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0001/arch/sh/include/cpu-sh4/cpu/sh7722.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7722.h	2009-06-03 15:59:50.000000000 +0900
@@ -1,6 +1,20 @@
 #ifndef __ASM_SH7722_H__
 #define __ASM_SH7722_H__
 
+/* Boot Mode Pins:
+ *
+ * MD0: CPG - Clock Mode 0->3
+ * MD1: CPG - Clock Mode 0->3
+ * MD2: CPG - Reserved (L: Normal operation)
+ * MD3: BSC - Area0 Bus Width (16/32-bit) [CS0BCR.9,10]
+ * MD5: BSC - Endian Mode (L: Big, H: Little) [CMNCR.3]
+ * MD8: Test Mode
+ */
+
+/* Pin Function Controller:
+ * GPIO_FN_xx - GPIO used to select pin function
+ * GPIO_Pxx - GPIO mapped to real I/O pin on CPU
+ */
 enum {
 	/* PTA */
 	GPIO_PTA7, GPIO_PTA6, GPIO_PTA5, GPIO_PTA4,
