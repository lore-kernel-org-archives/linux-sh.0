From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Dec 2010 14:15:08 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0: fix div4 table
Message-Id: <20101222141508.2302.53930.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takashi YOSHII <takashi.yoshii.zj@renesas.com>

sh73a0 has divisor[12] setting as 1/7 on FRQCRA.

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2010-12-22 23:10:48.000000000 +0900
@@ -191,7 +191,7 @@ static void div4_kick(struct clk *clk)
 }
 
 static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 18,
-			  24, 0, 36, 48 };
+			  24, 0, 36, 48, 7 };
 
 static struct clk_div_mult_table div4_div_mult_table = {
 	.divisors = divisors,
