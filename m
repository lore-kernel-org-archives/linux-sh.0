From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 10:09:51 +0000
Subject: [PATCH] sh: Introduce clk_always_enable() function
Message-Id: <20080717100951.19598.70512.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add SuperH specific funcion clk_always_enable(), useful to enable MSTPCR
bits in processor or board specific code. 

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/asm-sh/clock.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- 0008/include/asm-sh/clock.h
+++ work/include/asm-sh/clock.h	2008-07-17 12:42:28.000000000 +0900
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/seq_file.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 struct clk;
 
@@ -47,6 +48,22 @@ void clk_recalc_rate(struct clk *);
 int clk_register(struct clk *);
 void clk_unregister(struct clk *);
 
+static inline int clk_always_enable(const char *id)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = clk_get(NULL, id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_enable(clk);
+	if (ret)
+		clk_put(clk);
+
+	return ret;
+}
+
 /* the exported API, in addition to clk_set_rate */
 /**
  * clk_set_rate_ex - set the clock rate for a clock source, with additional parameter
