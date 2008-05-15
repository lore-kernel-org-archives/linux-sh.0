From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 15 May 2008 08:44:00 +0000
Subject: [PATCH] sh: fix sh7785 master clock value
Message-Id: <482BF7D0.4080109@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index 805535a..27fa81b 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -26,7 +26,7 @@ static int pfc_divisors[] = { 1, 1, 1, 1, 1, 1, 1, 18,

 static void master_clk_init(struct clk *clk)
 {
-	clk->rate *= 36;
+	clk->rate *= pfc_divisors[ctrl_inl(FRQMR1) & 0x000f];
 }

 static struct clk_ops sh7785_master_clk_ops = {

