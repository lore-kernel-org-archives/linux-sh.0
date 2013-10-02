From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 06:14:12 +0000
Subject: [PATCH 3/3] ARM: shmobile: bockw: add SMSC support on DT
Message-Id: <87txh0yzbj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables SMSC on BockW board via DT.
SMSC interrupt is connected to FPGA, and is connected
to IRQ0 on BockW.
This patch enabled INTC IRQ too

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   27 +++++++++++++++++++++++-
 arch/arm/mach-shmobile/board-bockw-reference.c |   20 ++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 9bb903a..4425fd2 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -22,11 +22,36 @@
 	compatible = "renesas,bockw-reference", "renesas,r8a7778";
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel rw";
+		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
 	};
 
 	memory {
 		device_type = "memory";
 		reg = <0x60000000 0x10000000>;
 	};
+
+	fixedregulator3v3: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lan0@18300000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18300000 0x1000>;
+
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin>;
+		interrupts = <0 0>; /* IRQ0: hwirq 0 on irqpin */
+		reg-io-width = <4>;
+		vddvario-supply = <&fixedregulator3v3>;
+		vdd33a-supply = <&fixedregulator3v3>;
+	};
+};
+
+&irqpin {
+	status = "okay";
 };
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 1a7c893..ae88fda 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -36,15 +36,35 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 				  "scif0_ctrl", "scif0"),
 };
 
+#define FPGA	0x18200000
+#define IRQ0MR	0x30
+#define COMCTLR	0x101c
 static void __init bockw_init(void)
 {
+	static void __iomem *fpga;
+
 	r8a7778_clock_init();
+	r8a7778_init_irq_extpin_dt(1);
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
 	r8a7778_add_dt_devices();
 
+	fpga = ioremap_nocache(FPGA, SZ_1M);
+	if (fpga) {
+		/*
+		 * CAUTION
+		 *
+		 * IRQ0/1 is cascaded interrupt from FPGA.
+		 * it should be cared in the future
+		 * Now, it is assuming IRQ0 was used only from SMSC.
+		 */
+		u16 val = ioread16(fpga + IRQ0MR);
+		val &= ~(1 << 4); /* enable SMSC911x */
+		iowrite16(val, fpga + IRQ0MR);
+	}
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.9.5

