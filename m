From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 07 Feb 2013 23:31:40 +0000
Subject: [PATCH 1/3] ARM: shmobile: add MMCIF and SDHI DT clock aliases to sh73a0 and r8a7740
Message-Id: <Pine.LNX.4.64.1302080026580.30556@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add clock lookup entries for SDHI and MMCIF device names, for the FDT case.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    4 ++++
 arch/arm/mach-shmobile/clock-sh73a0.c  |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 8765a76..83209bf 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -611,12 +611,16 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0",	&mstp_clks[MSTP314]),
+	CLKDEV_DEV_ID("e6850000.sdhi",		&mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1",	&mstp_clks[MSTP313]),
+	CLKDEV_DEV_ID("e6860000.sdhi",		&mstp_clks[MSTP313]),
 	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
+	CLKDEV_DEV_ID("e6bd0000.mmcif",		&mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
+	CLKDEV_DEV_ID("e6870000.sdhi",		&mstp_clks[MSTP415]),
 
 	/* ICK */
 	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index afa5423..5fa106b 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -581,10 +581,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6822000.i2c", &mstp_clks[MSTP323]), /* I2C1 */
 	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP322]), /* USB */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
+	CLKDEV_DEV_ID("ee100000.sdhi", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
+	CLKDEV_DEV_ID("ee120000.sdhi", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("e6bd0000.mmcif", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]), /* SDHI2 */
+	CLKDEV_DEV_ID("ee140000.sdhi", &mstp_clks[MSTP311]), /* SDHI2 */
 	CLKDEV_DEV_ID("leds-renesas-tpu.12", &mstp_clks[MSTP303]), /* TPU1 */
 	CLKDEV_DEV_ID("leds-renesas-tpu.21", &mstp_clks[MSTP302]), /* TPU2 */
 	CLKDEV_DEV_ID("leds-renesas-tpu.30", &mstp_clks[MSTP301]), /* TPU3 */
-- 
1.7.2.5

