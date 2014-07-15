From: Daniel Palmer <danieruru@gmail.com>
Date: Tue, 15 Jul 2014 06:19:17 +0000
Subject: [PATCH 1/1] SH7724 clock fixes
Message-Id: <1405405157-15316-1-git-send-email-danieruru@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

 Fix the device name for the CMT
 Add clocks called usb0 and usb1 so that r8a66597_hcd works again on the ecovec24 board

Signed-off-by: Daniel Palmer <danieruru@gmail.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index f579dd5..c187b95 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -307,7 +307,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[HWBLK_TMU0]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.1", &mstp_clks[HWBLK_TMU1]),
 
-	CLKDEV_ICK_ID("fck", "sh-cmt-16.0", &mstp_clks[HWBLK_CMT]),
+	CLKDEV_ICK_ID("fck", "sh-cmt-32.0", &mstp_clks[HWBLK_CMT]),
 	CLKDEV_DEV_ID("sh-wdt.0", &mstp_clks[HWBLK_RWDT]),
 	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[HWBLK_DMAC1]),
 
@@ -332,6 +332,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("tsif0", &mstp_clks[HWBLK_TSIF]),
 	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[HWBLK_USB1]),
 	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[HWBLK_USB0]),
+	CLKDEV_CON_ID("usb1", &mstp_clks[HWBLK_USB1]),
+	CLKDEV_CON_ID("usb0", &mstp_clks[HWBLK_USB0]),
 	CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[HWBLK_SDHI0]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[HWBLK_SDHI1]),
-- 
2.0.1

