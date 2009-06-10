From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 10 Jun 2009 05:35:22 +0000
Subject: [PATCH] sh: fix clock for sh7785
Message-Id: <4A2F461A.8080506@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 Could you apply this patch to linux-2.6.30?
 If impossible, this patch is not necessary because clock-sh7785.c will modify
 in linux-2.6.31.

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -uprN a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -26,7 +26,9 @@ static int pfc_divisors[] = { 1, 1, 1, 1

 static void master_clk_init(struct clk *clk)
 {
-	clk->rate *= pfc_divisors[ctrl_inl(FRQMR1) & 0x000f];
+	unsigned long frqmr1 = ctrl_inl(FRQMR1);
+
+	clk->rate = CONFIG_SH_PCLK_FREQ * pfc_divisors[frqmr1 & 0x000f];
 }

 static struct clk_ops sh7785_master_clk_ops = {
