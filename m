From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Feb 2010 09:12:00 +0000
Subject: [PATCH] sh: clock-cpg div4 set_rate() shift fix
Message-Id: <20100219091200.472.86301.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Make sure the div4 bitfield is shifted according
to the enable_bit value in sh_clk_div4_set_rate().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/clock-cpg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/clock-cpg.c
+++ work/arch/sh/kernel/cpu/clock-cpg.c	2010-02-19 16:21:09.000000000 +0900
@@ -192,8 +192,8 @@ static int sh_clk_div4_set_rate(struct c
 		return idx;
 
 	value = __raw_readl(clk->enable_reg);
-	value &= ~0xf;
-	value |= idx;
+	value &= ~(0xf << clk->enable_bit);
+	value |= (idx << clk->enable_bit);
 	__raw_writel(value, clk->enable_reg);
 
 	return 0;
