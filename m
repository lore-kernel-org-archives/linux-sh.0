From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 08 Feb 2013 18:38:26 +0000
Subject: [PATCH v2 2/8] ARM: shmobile: add SDHI and MMCIF interfaces to armadillo800eva-reference
Message-Id: <1360348712-29255-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add SDHI0, SDHI1 and MMCIF interfaces to armadillo800eva-reference. With
no pinctrl DT support we cannot use GPIO card-detection and regulator
switching.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: unchanged

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   44 +++++++++++++++++
 .../board-armadillo800eva-reference.c              |   52 ++++++++++++++++++++
 2 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index f7db06d..bd6d724 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -34,4 +34,48 @@
 		sh-eth,register-type = "gigabit";
 		sh-eth,phy-id = <0>;
 	};
+
+	reg_3p3v: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	mmcif0: mmcif@0xe6bd0000 {
+		compatible = "renesas,sh-mmcif", "renesas,sh7372-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x1ac0 0x1ae0>;
+		vmmc-supply = <&reg_3p3v>;
+		bus-width = <8>;
+		non-removable;
+	};
+
+	sdhi0: sdhi@0xe6850000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xe6850000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0xe20 0xe40>;
+		vmmc-supply = <&reg_3p3v>;
+		bus-width = <4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		broken-cd;
+		toshiba,mmc-has-idle-wait;
+	};
+
+	sdhi1: sdhi@0xe6860000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xe6860000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0xe80 0xea0 0xec0>;
+		vmmc-supply = <&reg_3p3v>;
+		bus-width = <4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		toshiba,mmc-has-idle-wait;
+	};
 };
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index e31030e..f280fa7 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -138,6 +138,58 @@ static void __init eva_init(void)
 	gpio_request(GPIO_PORT18, NULL); /* PHY_RST */
 	gpio_direction_output(GPIO_PORT18, 1);
 
+	/* SDHI0 */
+	gpio_request(GPIO_FN_SDHI0_CMD, NULL);
+	gpio_request(GPIO_FN_SDHI0_CLK, NULL);
+	gpio_request(GPIO_FN_SDHI0_D0, NULL);
+	gpio_request(GPIO_FN_SDHI0_D1, NULL);
+	gpio_request(GPIO_FN_SDHI0_D2, NULL);
+	gpio_request(GPIO_FN_SDHI0_D3, NULL);
+	gpio_request(GPIO_FN_SDHI0_WP, NULL);
+
+	gpio_request_one(GPIO_PORT17, GPIOF_OUT_INIT_LOW, NULL);  /* SDHI0_18/33_B */
+	gpio_request_one(GPIO_PORT74, GPIOF_OUT_INIT_HIGH, NULL); /* SDHI0_PON */
+	gpio_request_one(GPIO_PORT75, GPIOF_OUT_INIT_HIGH, NULL); /* SDSLOT1_PON */
+
+	/*
+	 * MMCIF
+	 * Don't care about the SW1.4 status, since CON2 is not mounted.
+	 */
+	gpio_request(GPIO_FN_MMC1_CLK_PORT103,	NULL);
+	gpio_request(GPIO_FN_MMC1_CMD_PORT104,	NULL);
+	gpio_request(GPIO_FN_MMC1_D0_PORT149,	NULL);
+	gpio_request(GPIO_FN_MMC1_D1_PORT148,	NULL);
+	gpio_request(GPIO_FN_MMC1_D2_PORT147,	NULL);
+	gpio_request(GPIO_FN_MMC1_D3_PORT146,	NULL);
+	gpio_request(GPIO_FN_MMC1_D4_PORT145,	NULL);
+	gpio_request(GPIO_FN_MMC1_D5_PORT144,	NULL);
+	gpio_request(GPIO_FN_MMC1_D6_PORT143,	NULL);
+	gpio_request(GPIO_FN_MMC1_D7_PORT142,	NULL);
+
+	/*
+	 * CAUTION
+	 * DBGMD/LCDC0/FSIA MUX
+	 * DBGMD_SELECT_B should be set after setting PFC Function.
+	 */
+	gpio_request_one(GPIO_PORT176, GPIOF_OUT_INIT_HIGH, NULL);
+
+	/* We can switch CON8/CON14 by SW1.5, but only after DBGMD_SELECT_B */
+	gpio_request_one(GPIO_PORT6, GPIOF_IN, NULL);
+	if (!gpio_get_value(GPIO_PORT6)) {
+		/* CON14 disabled, CON8 (SDHI1) enabled */
+		gpio_request(GPIO_FN_SDHI1_CLK,	NULL);
+		gpio_request(GPIO_FN_SDHI1_CMD,	NULL);
+		gpio_request(GPIO_FN_SDHI1_D0,	NULL);
+		gpio_request(GPIO_FN_SDHI1_D1,	NULL);
+		gpio_request(GPIO_FN_SDHI1_D2,	NULL);
+		gpio_request(GPIO_FN_SDHI1_D3,	NULL);
+		gpio_request(GPIO_FN_SDHI1_CD,	NULL);
+		gpio_request(GPIO_FN_SDHI1_WP,	NULL);
+
+		/* SDSLOT2_PON */
+		gpio_request_one(GPIO_PORT16, GPIOF_OUT_INIT_HIGH, NULL);
+	}
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
 	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
-- 
1.7.2.5

