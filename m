From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Dec 2011 16:52:11 +0000
Subject: [PATCH 02/07] sh: CPG MSTP ioremap() prototype hack
Message-Id: <20111206165211.19348.25335.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Hack to use the cookie returned from ioremap(). Will be rewritten
and submitted separately in the near future. Needed by the r8a7779
clock code since entity mapping is out of the question.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/clk/cpg.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 0001/drivers/sh/clk/cpg.c
+++ work/drivers/sh/clk/cpg.c	2011-12-07 00:32:11.000000000 +0900
@@ -42,6 +42,10 @@ int __init sh_clk_mstp32_register(struct
 		clkp = clks + k;
 		clkp->ops = &sh_clk_mstp32_clk_ops;
 		ret |= clk_register(clkp);
+		if (!ret && clkp->mapping->base) {
+			clkp->enable_reg -= clkp->mapping->phys;
+			clkp->enable_reg += (unsigned long)clkp->mapping->base;
+		}
 	}
 
 	return ret;
