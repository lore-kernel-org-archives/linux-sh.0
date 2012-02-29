From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:17:16 +0000
Subject: [PATCH 09/17] sh: sh header sh_clk_ops rename
Message-Id: <20120229131716.29154.57997.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the sh include asm/clock.h to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2012-02-29 20:05:00.000000000 +0900
@@ -4,7 +4,7 @@
 #include <linux/sh_clk.h>
 
 /* Should be defined by processor-specific code */
-void __deprecated arch_init_clk_ops(struct clk_ops **, int type);
+void __deprecated arch_init_clk_ops(struct sh_clk_ops **, int type);
 int __init arch_clk_init(void);
 
 /* arch/sh/kernel/cpu/clock-cpg.c */
