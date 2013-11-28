From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:03:52 +0000
Subject: [PATCH v3 15/15] ARM: shmobile: r8a7790: Remove legacy clock aliases for DT devices
Message-Id: <1385600632-5181-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that the r8a7790 DT platforms use the common clock framework,
there's no need to manually create clock aliases for devices
instantiated through DT, as those devices will reference their clocks
directly in the device tree. Remove those aliases.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 7960dc0..a33ac69 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -276,24 +276,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
-	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
-	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
-	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
-	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
-	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
-	CLKDEV_DEV_ID("ee100000.sd", &mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]),
-	CLKDEV_DEV_ID("ee120000.sd", &mstp_clks[MSTP313]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]),
-	CLKDEV_DEV_ID("ee140000.sd", &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
-	CLKDEV_DEV_ID("ee160000.sd", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP311]),
-	CLKDEV_DEV_ID("ee220000.mmc", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
-- 
1.8.3.2

