From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Dec 2010 06:14:05 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 CPGA fix for KEYSC
Message-Id: <20101222061405.25163.82564.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the sh73a0 KEYSC clock control by adding MSTP403
to mstp_clks[]. Use KEYSC instead of KEYSC0 in comments.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh73a0.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0005/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2010-12-22 15:03:26.000000000 +0900
@@ -282,6 +282,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 10, 0), /* IIC4 */
+	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
@@ -309,7 +310,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
-	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC0 */
+	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
 };
 
 void __init sh73a0_clock_init(void)
