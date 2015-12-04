From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Dec 2015 03:18:28 +0000
Subject: [PATCH 4/4] ARM: shmobile: r8a7791: enable to use thermal-zone
Message-Id: <87vb8egaz9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871tb2hpn2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871tb2hpn2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables to use thermal-zone on r8a7791.
This thermal sensor can measure temperature from -40000 to 125000,
but over 117000 can be critical on this chip.
Thus, default critical temperature is now set as 115000 (this driver
is using 5000 steps) (Current critical temperature is using it as
90000, but there is no big reason about it)

And it doesn't check thermal zone periodically (same as current
behavior). You can exchange it by modifing polling-delay[-passive]
property.

You can set trip temp if your kernel has CONFIG_THERMAL_WRITABLE_TRIPS,
but you need to take care to use it, since it will call
orderly_poweroff() it it reached to the value.
echo $temp > /sys/class/thermal/thermal_zone0/trip_point_0_temp

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1487d92..2fff856 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -69,6 +69,25 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive	= <0>;
+			polling-delay		= <0>;
+
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu-crit {
+					temperature	= <1150000>;
+					hysteresis	= <0>;
+					type		= "critical";
+				};
+			};
+			cooling-maps {
+			};
+		};
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
@@ -185,12 +204,15 @@
 		power-domains = <&cpg_clocks>;
 	};
 
-	thermal@e61f0000 {
-		compatible = "renesas,thermal-r8a7791", "renesas,rcar-thermal";
+	thermal: thermal@e61f0000 {
+		compatible =	"renesas,thermal-r8a7791",
+				"renesas,rcar-thermal-gen2",
+				"renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
 		power-domains = <&cpg_clocks>;
+		#thermal-sensor-cells = <0>;
 	};
 
 	timer {
-- 
1.9.1

