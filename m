From: Simon Horman <horms+renesas@verge.net.au>
Date: Sun, 15 Dec 2013 08:24:45 +0000
Subject: [PATCH RFC 2/3] [RFC] ARM: shmobile: r7s72100: Add clock for r7s72100-gether
Message-Id: <1387095886-15163-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387095886-15163-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1387095886-15163-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 7b457ae..7bce0c1 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -27,6 +27,7 @@
 #define FRQCR2		0xfcfe0014
 #define STBCR3		0xfcfe0420
 #define STBCR4		0xfcfe0424
+#define STBCR7		0xfcfe0430
 
 #define PLL_RATE 30
 
@@ -145,9 +146,10 @@ struct clk div4_clks[DIV4_NR] = {
 };
 
 enum { MSTP47, MSTP46, MSTP45, MSTP44, MSTP43, MSTP42, MSTP41, MSTP40,
-	MSTP33,	MSTP_NR };
+	MSTP33,	MSTP74, MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP74] = SH_CLK_MSTP8(&peripheral1_clk, STBCR7, 4, 0), /* GEther */
 	[MSTP47] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 7, 0), /* SCIF0 */
 	[MSTP46] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 6, 0), /* SCIF1 */
 	[MSTP45] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 5, 0), /* SCIF2 */
@@ -170,6 +172,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_DEV_ID("r7s72100-gether", &mstp_clks[MSTP74]),
 	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 
 	/* ICK */
-- 
1.8.4

