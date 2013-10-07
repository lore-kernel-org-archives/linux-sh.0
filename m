From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 07 Oct 2013 04:26:58 +0000
Subject: [PATCH 2/2] ARM: shmobile: lager: add MMCIF support on DTS
Message-Id: <87d2nhbt9s.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index 0a3f0c6..75730f5 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -42,6 +42,15 @@
 			gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
 		};
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
 };
 
 &pfc {
@@ -57,4 +66,19 @@
 		renesas,groups = "scif1_data";
 		renesas,function = "scif1";
 	};
+
+	mmc1_pins: mmc1 {
+		renesas,groups = "mmc1_data8", "mmc1_ctrl";
+		renesas,function = "mmc1";
+	};
+};
+
+&mmcif1 {
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&fixedregulator3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
 };
-- 
1.7.9.5

