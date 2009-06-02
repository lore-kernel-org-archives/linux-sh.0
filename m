From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Jun 2009 10:47:32 +0000
Subject: [PATCH] sh: sh7724 mode pin comments
Message-Id: <20090602104732.22485.34447.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds comments for the sh7724 mode pins
and pin function controller.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/cpu-sh4/cpu/sh7724.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0001/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7724.h	2009-06-02 19:38:51.000000000 +0900
@@ -1,6 +1,20 @@
 #ifndef __ASM_SH7724_H__
 #define __ASM_SH7724_H__
 
+/* Boot Mode Pins:
+ *
+ * MD0: CPG - Clock Mode 0->7
+ * MD1: CPG - Clock Mode 0->7
+ * MD2: CPG - Clock Mode 0->7
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
