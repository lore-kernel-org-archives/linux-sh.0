From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 May 2009 13:44:40 +0000
Subject: [PATCH] sh: clkfwk branch compile fix for clock-sh7722
Message-Id: <20090520134440.7441.27247.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix clkfwk branch compile error in clock-sh7722.c.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2009-05-20 13:34:25.000000000 +0900
@@ -892,7 +892,7 @@ int __init arch_clk_init(void)
 	struct clk *clk;
 	int i;
 
-	clk_cpg_init();
+	cpg_clk_init();
 
 	clk = clk_get(NULL, "master_clk");
 	for (i = 0; i < ARRAY_SIZE(sh7722_clocks); i++) {
