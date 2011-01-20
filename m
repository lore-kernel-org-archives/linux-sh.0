From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Jan 2011 08:11:11 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 CPGA fix for PLL CFG bit
Message-Id: <20110120081111.9368.87160.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20101222061405.25163.82564.sendpatchset@t400s>
In-Reply-To: <20101222061405.25163.82564.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

PLL1 and PLL2 in the sh73a0 CPGA has a CFG bit that
must be taken into account to correctly calculate the
frequency.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh73a0.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-01-20 15:23:06.000000000 +0900
@@ -118,8 +118,16 @@ static unsigned long pll_recalc(struct c
 {
 	unsigned long mult = 1;
 
-	if (__raw_readl(PLLECR) & (1 << clk->enable_bit))
+	if (__raw_readl(PLLECR) & (1 << clk->enable_bit)) {
 		mult = (((__raw_readl(clk->enable_reg) >> 24) & 0x3f) + 1);
+		/* handle CFG bit for PLL1 and PLL2 */
+		switch (clk->enable_bit) {
+		case 1:
+		case 2:
+			if (__raw_readl(clk->enable_reg) & (1 << 20))
+				mult *= 2;
+		}
+	}
 
 	return clk->parent->rate * mult;
 }
