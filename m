From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 09:19:34 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: Fix ethernet device name in clock definition
Message-Id: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The ethernet device is named r8a7740-gether, fix the clock definition
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index de10fd7..e1e8710 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -595,7 +595,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("r8a7740-gether",		&mstp_clks[MSTP309]),
-	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
+	CLKDEV_DEV_ID("e9a00000.r8a7740-gether", &mstp_clks[MSTP309]),
 	CLKDEV_DEV_ID("renesas_tpu_pwm",	&mstp_clks[MSTP304]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
-- 
Regards,

Laurent Pinchart

