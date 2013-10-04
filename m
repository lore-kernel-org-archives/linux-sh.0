From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Oct 2013 07:20:31 +0000
Subject: [PATCH v3 2/3] ARM: shmobile: lager: add Device Tree entries for CA15 CPUFreq support
Message-Id: <1380871232-31896-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds a regulator and CA15 Operating Performance Points for the
Lager board, necessary for the CPUFreq support, to the Device Tree.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v3: .dts part of former patch 5/5

 arch/arm/boot/dts/r8a7790-lager-reference.dts |   33 +++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index c462ef1..1ce0a97 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -43,3 +43,36 @@
 		};
 	};
 };
+
+&i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
+	vdd_dvfs: da9210@68 {
+		compatible = "diasemi,da9210";
+		reg = <0x68>;
+
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+	operating-points = <
+		/* kHz  uV - OPs unknown yet */
+		1300000 1000000
+		1000000  900000
+	>;
+	voltage-tolerance = <1>; /* 1% */
+};
+
+&pfc {
+	i2c3_pins: i2c3 {
+		renesas,groups = "i2c3";
+		renesas,function = "i2c3";
+	};
+};
-- 
1.7.2.5

