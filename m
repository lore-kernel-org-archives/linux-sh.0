From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Aug 2012 07:54:22 +0000
Subject: [PATCH 1/2] sh: sh7724: fixup renesas_usbhs clock settings
Message-Id: <873947dp3o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

8cc88a55b03bd4940390125c2521c99368513be5
(sh: sh7724: use runtime PM implementation) broke sh7724 clocks.

renesas_usbhs needs HWBLK_USB0/1 clock on sh7724

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index c87e78f..5f30f80 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -334,8 +334,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("tpu0", &mstp_clks[HWBLK_TPU]),
 	CLKDEV_CON_ID("irda0", &mstp_clks[HWBLK_IRDA]),
 	CLKDEV_CON_ID("tsif0", &mstp_clks[HWBLK_TSIF]),
-	CLKDEV_CON_ID("usb1", &mstp_clks[HWBLK_USB1]),
-	CLKDEV_CON_ID("usb0", &mstp_clks[HWBLK_USB0]),
+	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[HWBLK_USB1]),
+	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[HWBLK_USB0]),
 	CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[HWBLK_SDHI0]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[HWBLK_SDHI1]),
-- 
1.7.5.4

