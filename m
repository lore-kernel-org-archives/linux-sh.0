From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 17:30:02 +0000
Subject: [PATCH v6 1/2] ARM: shmobile: r8a73a4: add a clock alias for the DMAC in DT mode
Message-Id: <1380216603-14645-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Devices, initialised from the Device Tree and from platform code usually
have different names. This patch adds a clock alias for DMAC on r8a73a4
in DT mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 357b9bc..74841ed 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -580,6 +580,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]),
+	CLKDEV_DEV_ID("e6700020.dma-controller", &mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("e6520000.i2c", &mstp_clks[MSTP300]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
-- 
1.7.2.5

