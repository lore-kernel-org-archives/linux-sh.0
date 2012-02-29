From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:17:08 +0000
Subject: [PATCH 08/17] ARM: mach-shmobile: r8a7779 sh_clk_ops rename
Message-Id: <20120229131708.29154.33756.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert r8a7779 to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7779.c
+++ work/arch/arm/mach-shmobile/clock-r8a7779.c	2012-02-28 22:17:31.000000000 +0900
@@ -107,7 +107,7 @@ static unsigned long mul4_recalc(struct
 	return clk->parent->rate * 4;
 }
 
-static struct clk_ops mul4_clk_ops = {
+static struct sh_clk_ops mul4_clk_ops = {
 	.recalc		= mul4_recalc,
 };
 
