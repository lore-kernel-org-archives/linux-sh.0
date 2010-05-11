From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 07:05:09 +0000
Subject: [PATCH 01/09] sh: div4 reparent workaround
Message-Id: <20100511070509.20792.80390.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the div4 set_parent() callback to use the
flags instead of name to determine parent index.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/clock-cpg.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2010-05-11 14:38:56.000000000 +0900
@@ -168,7 +168,12 @@ static int sh_clk_div4_set_parent(struct
 	u32 value;
 	int ret;
 
-	if (!strcmp("pll_clk", parent->name))
+	/* we really need a better way to determine parent index, but for
+	 * now assume internal parent comes with CLK_ENABLE_ON_INIT set,
+	 * no CLK_ENABLE_ON_INIT means external clock...
+	 */
+
+	if (parent->flags & CLK_ENABLE_ON_INIT)
 		value = __raw_readl(clk->enable_reg) & ~(1 << 7);
 	else
 		value = __raw_readl(clk->enable_reg) | (1 << 7);
