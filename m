From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 19 Feb 2014 17:03:31 +0000
Subject: [PATCH] ARM: shmobile: r8a7791: Remove legacy clock aliases for DT devices
Message-Id: <1392829411-3952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that the r8a7791 DT platforms use the common clock framework,
there's no need to manually create clock aliases for devices
instantiated through DT, as those devices will reference their clocks
directly in the device tree. Remove those aliases.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 3e1b6b6..605fc77 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -267,7 +267,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
-	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.0", &mstp_clks[MSTP931]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.1", &mstp_clks[MSTP930]),
-- 
Regards,

Laurent Pinchart

