From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 Jan 2015 02:45:51 +0000
Subject: [PATCH] clk: shmobile: fix sparse NULL pointer warning
Message-Id: <16bd794f9432b556ec797cbf16c5e575a18f7030.1421376276.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1421376276.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1421376276.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

drivers/clk/shmobile/clk-sh73a0.c:57:17: warning:
 Using plain integer as NULL pointer

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clk/shmobile/clk-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-sh73a0.c b/drivers/clk/shmobile/clk-sh73a0.c
index 8574a6d..cd529cf 100644
--- a/drivers/clk/shmobile/clk-sh73a0.c
+++ b/drivers/clk/shmobile/clk-sh73a0.c
@@ -54,7 +54,7 @@ static struct div4_clk div4_clks[] = {
 	{ "m2", "pll1", CPG_FRQCRA,  0 },
 	{ "zx", "pll1", CPG_FRQCRB, 12 },
 	{ "hp", "pll1", CPG_FRQCRB,  4 },
-	{ NULL, 0, 0, 0 },
+	{ NULL, NULL, 0, 0 },
 };
 
 static const struct clk_div_table div4_div_table[] = {
-- 
2.1.4

