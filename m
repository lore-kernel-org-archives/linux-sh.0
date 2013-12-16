From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 16 Dec 2013 04:50:18 +0000
Subject: [PATCH 4/6][RFC] mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7790
Message-Id: <874n691jso.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates r8a7790 DT data to have SoC specific settings.
Latest Renesas Chip has some SDHI channels and the WP pin
availability depends on its channel or HW implementation.
Thus, this patch disables it as default,
but we can use wp-gpios property to enable it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi    |    4 ----
 drivers/mmc/host/sh_mobile_sdhi.c |   10 +++++++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 68b7b87..7ac2c9a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -257,7 +257,6 @@
 		reg = <0 0xee100000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -266,7 +265,6 @@
 		reg = <0 0xee120000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -275,7 +273,6 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 
@@ -284,7 +281,6 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
 		status = "disabled";
 	};
 };
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 322cd35..7498f5b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -38,6 +38,7 @@
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
 	unsigned long capabilities;
+	unsigned long capabilities2;
 };
 
 static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
@@ -51,6 +52,12 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
 
+static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.capabilities2	= MMC_CAP2_NO_MULTI_READ,
+};
+
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh7372" },
@@ -59,7 +66,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7790", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
@@ -219,6 +226,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
 		mmc_data->flags |= of_data->tmio_flags;
 		mmc_data->capabilities |= of_data->capabilities;
+		mmc_data->capabilities2 |= of_data->capabilities2;
 	}
 
 	/* SD control register space size is 0x100, 0x200 for bus_shift=1 */
-- 
1.7.9.5

