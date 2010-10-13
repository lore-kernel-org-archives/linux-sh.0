From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Oct 2010 07:29:31 +0000
Subject: [PATCH] ARM: shmobile: use device name for timer clocks
Message-Id: <20101013072931.19736.93158.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move SH-Mobile ARM systems over from the legacy
"clk" member of struct sh_timer_config to using
the device name and clkdev for clock matching.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7367.c |    2 +-
 arch/arm/mach-shmobile/clock-sh7372.c |    2 +-
 arch/arm/mach-shmobile/clock-sh7377.c |    2 +-
 arch/arm/mach-shmobile/setup-sh7367.c |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c |    1 -
 arch/arm/mach-shmobile/setup-sh7377.c |    1 -
 6 files changed, 3 insertions(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7367.c
+++ work/arch/arm/mach-shmobile/clock-sh7367.c	2010-10-13 15:40:25.000000000 +0900
@@ -321,7 +321,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[SYMSTP001]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[SYMSTP000]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh_siu", &mstp_clks[SYMSTP231]), /* SIU */
-	CLKDEV_CON_ID("cmt1", &mstp_clks[SYMSTP229]), /* CMT10 */
+	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[SYMSTP229]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_irda", &mstp_clks[SYMSTP225]), /* IRDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[SYMSTP223]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[SYMSTP222]), /* USBHS */
--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2010-10-13 15:40:00.000000000 +0900
@@ -516,7 +516,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP202]), /* SCIFA2 */
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
-	CLKDEV_CON_ID("cmt1", &mstp_clks[MSTP329]), /* CMT10 */
+	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI2 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP323]), /* USB0 */
--- 0001/arch/arm/mach-shmobile/clock-sh7377.c
+++ work/arch/arm/mach-shmobile/clock-sh7377.c	2010-10-13 15:40:45.000000000 +0900
@@ -333,7 +333,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
-	CLKDEV_CON_ID("cmt1", &mstp_clks[MSTP329]), /* CMT10 */
+	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_irda", &mstp_clks[MSTP325]), /* IRDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP322]), /* USBHS */
--- 0001/arch/arm/mach-shmobile/setup-sh7367.c
+++ work/arch/arm/mach-shmobile/setup-sh7367.c	2010-10-13 15:41:04.000000000 +0900
@@ -154,7 +154,6 @@ static struct sh_timer_config cmt10_plat
 	.name = "CMT10",
 	.channel_offset = 0x10,
 	.timer_bit = 0,
-	.clk = "r_clk",
 	.clockevent_rating = 125,
 	.clocksource_rating = 125,
 };
--- 0008/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2010-10-13 15:41:29.000000000 +0900
@@ -159,7 +159,6 @@ static struct sh_timer_config cmt10_plat
 	.name = "CMT10",
 	.channel_offset = 0x10,
 	.timer_bit = 0,
-	.clk = "cmt1",
 	.clockevent_rating = 125,
 	.clocksource_rating = 125,
 };
--- 0001/arch/arm/mach-shmobile/setup-sh7377.c
+++ work/arch/arm/mach-shmobile/setup-sh7377.c	2010-10-13 15:41:10.000000000 +0900
@@ -172,7 +172,6 @@ static struct sh_timer_config cmt10_plat
 	.name = "CMT10",
 	.channel_offset = 0x10,
 	.timer_bit = 0,
-	.clk = "r_clk",
 	.clockevent_rating = 125,
 	.clocksource_rating = 125,
 };
