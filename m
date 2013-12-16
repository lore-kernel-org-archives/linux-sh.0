From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 16 Dec 2013 04:50:04 +0000
Subject: [PATCH 3/6][RFC] mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7779
Message-Id: <8761qp1jt3.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates r8a7779 DT data to have SoC specific settings.
Latest Renesas Chip has some SDHI channels and the WP pin
availability depends on its channel or HW implementation.
Thus, this patch disables it as default,
but we can use wp-gpios property to enable it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779.dtsi    |    8 --------
 drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d0561d4..2105059 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -220,8 +220,6 @@
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -230,8 +228,6 @@
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -240,8 +236,6 @@
 		reg = <0xffe4e000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -250,8 +244,6 @@
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 6442286..322cd35 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -58,7 +58,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a73a4", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7779", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7790", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{},
 };
-- 
1.7.9.5

