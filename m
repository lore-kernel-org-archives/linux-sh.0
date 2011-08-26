From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 05:28:42 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 CMT3 and CMT4 clock support
Message-Id: <20110826052842.25747.73363.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add clock control support for sh7372 CMT hardware blocks.

No upstream sh7372 boards are making use of CMT3 + CMT4,
but the sh7372 hardware happens to come out of reset with
all CMT MSTP clocks _enabled_, so to save power we need
to implement a fix in software to shut down unused clocks.

This patch relies on the recently merged

 794d78f drivers: sh: late disabling of clocks V2

to make sure the unused clocks get disabled as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 This patch is needed by upcoming A3SM sleep mode support
 code that can only enter deep sleep in case most clocks
 are disabled - including these CMT clocks.

 arch/arm/mach-shmobile/clock-sh7372.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- 0008/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2011-08-26 13:50:55.000000000 +0900
@@ -512,7 +512,8 @@ enum { MSTP001, MSTP000,
        MSTP218, MSTP217, MSTP216, MSTP214, MSTP208,
        MSTP207, MSTP206, MSTP205, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
        MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
-       MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP407, MSTP406, MSTP403,
+       MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP407, MSTP406,
+       MSTP405, MSTP404, MSTP403,
        MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -563,6 +564,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP410] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 10, 0), /* IIC4 */
 	[MSTP407] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 7, 0), /* USB-DMAC1 */
 	[MSTP406] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 6, 0), /* USB1 */
+	[MSTP405] = MSTP(&r_clk, SMSTPCR4, 5, 0), /* CMT4 */
+	[MSTP404] = MSTP(&r_clk, SMSTPCR4, 4, 0), /* CMT3 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
 };
 
@@ -663,6 +666,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a66597_hcd.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("r8a66597_udc.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[MSTP406]), /* USB1 */
+	CLKDEV_DEV_ID("sh_cmt.4", &mstp_clks[MSTP405]), /* CMT4 */
+	CLKDEV_DEV_ID("sh_cmt.3", &mstp_clks[MSTP404]), /* CMT3 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
 
 	CLKDEV_ICK_ID("hdmi", "sh_mobile_lcdc_fb.1",
