From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Jul 2013 16:04:58 +0000
Subject: [PATCH v3 2/2] ARM: shmobile: ape6evm-reference: add CPUFreq support
Message-Id: <1373299498-10044-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add CPUFreq support to ape6evm-reference, using a max8973 regulator, that
is supplying V_DVFS for the 4 CA15 cores on r8a73a4.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v3: call platform_device_register_simple() directly

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   22 ++++++++++++++++++++++
 arch/arm/mach-shmobile/board-ape6evm-reference.c |    2 ++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 3251f05..6f4506e 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -31,3 +31,25 @@
 		ranges = <0 0 0 0x80000000>;
 	};
 };
+
+&i2c5 {
+	vdd_dvfs: max8973@1b {
+		compatible = "maxim,max8973";
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
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index c828874..46b41de 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_device.h>
 #include <linux/sh_clk.h>
 #include <mach/common.h>
 #include <mach/r8a73a4.h>
@@ -56,6 +57,7 @@ static void __init ape6evm_add_standard_devices(void)
 	r8a73a4_pinmux_init();
 	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
-- 
1.7.2.5

