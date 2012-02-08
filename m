From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 08 Feb 2012 04:04:58 +0000
Subject: [PATCH] sh: add parameter for RSPI in clock-sh7757
Message-Id: <4F31F46A.1060008@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 0fbff14..0bd21c8 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -79,7 +79,7 @@ struct clk div4_clks[DIV4_NR] = {
 #define MSTPCR1		0xffc80034
 #define MSTPCR2		0xffc10028

-enum { MSTP004, MSTP000, MSTP114, MSTP113, MSTP112,
+enum { MSTP004, MSTP000, MSTP127, MSTP114, MSTP113, MSTP112,
        MSTP111, MSTP110, MSTP103, MSTP102, MSTP220,
        MSTP_NR };

@@ -89,6 +89,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP000] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 0, 0),

 	/* MSTPCR1 */
+	[MSTP127] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 27, 0),
 	[MSTP114] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 14, 0),
 	[MSTP113] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 13, 0),
 	[MSTP112] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 12, 0),
@@ -131,6 +132,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("usb_fck", &mstp_clks[MSTP103]),
 	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[MSTP102]),
 	CLKDEV_CON_ID("mmc0", &mstp_clks[MSTP220]),
+	CLKDEV_CON_ID("rspi2", &mstp_clks[MSTP127]),
 };

 int __init arch_clk_init(void)
-- 
1.7.1
