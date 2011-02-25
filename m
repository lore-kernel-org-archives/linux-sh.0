From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Feb 2011 07:39:49 +0000
Subject: [PATCH 4/7] sh: add mmc clock in clock-sh7757
Message-Id: <4D675CC5.1000804@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index e073e3e..eedddad 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -77,9 +77,10 @@ struct clk div4_clks[DIV4_NR] = {

 #define MSTPCR0		0xffc80030
 #define MSTPCR1		0xffc80034
+#define MSTPCR2		0xffc10028

 enum { MSTP004, MSTP000, MSTP114, MSTP113, MSTP112,
-       MSTP111, MSTP110, MSTP103, MSTP102,
+       MSTP111, MSTP110, MSTP103, MSTP102, MSTP220,
        MSTP_NR };

 static struct clk mstp_clks[MSTP_NR] = {
@@ -95,6 +96,9 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP110] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 10, 0),
 	[MSTP103] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 3, 0),
 	[MSTP102] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 2, 0),
+
+	/* MSTPCR2 */
+	[MSTP220] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR2, 20, 0),
 };

 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
@@ -140,6 +144,7 @@ static struct clk_lookup lookups[] = {
 		.clk		= &mstp_clks[MSTP110],
 	},
 	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP102]),
+	CLKDEV_CON_ID("mmc0", &mstp_clks[MSTP220]),
 };

 int __init arch_clk_init(void)
-- 
1.7.1
