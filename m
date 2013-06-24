From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 24 Jun 2013 11:05:16 +0000
Subject: [PATCH v2 3/4] ARM: shmobile: ape6evm: add CPUFreq support
Message-Id: <Pine.LNX.4.64.1306241257190.19735@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds OPPs to the CA15 DT node and a max8973 DT node to support
clock and voltage scaling, using the cpufreq-cpu0 CPUFreq driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: Subject to Mark acking v2 of my max8973 DT patch, this should be the 
updated version of my original ape6evm CPUFreq patch. This version puts 
all max8973 regulator bindings directly under the respective I2C device 
node instead of creating 2 additional levels.

 arch/arm/boot/dts/r8a73a4-ape6evm.dts |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 4fb0102..27c5e06 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -52,3 +52,25 @@
 		};
 	};
 };
+
+&i2c5 {
+	vdd_dvfs: max8973@1b {
+		compatible = "maxium,max8973";
+		reg = <0x1b>;
+
+		regulator-min-microvolt = <935000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	cpu0-supply = <&vdd_dvfs>;
+	operating-points = <
+		/* kHz  uV */
+		1950000 1115000
+		1462500  995000
+	>;
+	voltage-tolerance = <1>; /* 1% */
+};
-- 
1.7.2.5

