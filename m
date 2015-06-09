From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Tue, 09 Jun 2015 23:24:29 +0000
Subject: [PATCH v2 6/6] ARM: shmobile: lager: Enable UHS-I SDR-50
Message-Id: <1433892269.12074.55.camel@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1433892104.12074.49.camel@codethink.co.uk>
In-Reply-To: <1433892104.12074.49.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 5f68e53c58ae..ff5eea8ea765 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -314,11 +314,21 @@
 		renesas,function = "sdhi0";
 	};
 
+	sdhi0_pins_1v8: sd0_1v8 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,function = "sdhi0_1v8";
+	};
+
 	sdhi2_pins: sd2 {
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
 
+	sdhi2_pins_1v8: sd2_1v8 {
+		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2_1v8";
+	};
+
 	mmc1_pins: mmc1 {
 		renesas,groups = "mmc1_data8", "mmc1_ctrl";
 		renesas,function = "mmc1";
@@ -486,7 +496,8 @@
 
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi0_pins_1v8>;
+	pinctrl-names = "default", "1v8";
 
 	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 	assigned-clock-rates = <156000000>;
@@ -494,12 +505,14 @@
 	vmmc-supply = <&vcc_sdhi0>;
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
 &sdhi2 {
 	pinctrl-0 = <&sdhi2_pins>;
-	pinctrl-names = "default";
+	pinctrl-1 = <&sdhi2_pins_1v8>;
+	pinctrl-names = "default", "1v8";
 
 	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
 	assigned-clock-rates = <97500000>;
@@ -507,6 +520,7 @@
 	vmmc-supply = <&vcc_sdhi2>;
 	vqmmc-supply = <&vccq_sdhi2>;
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	sd-uhs-sdr50;
 	status = "okay";
 };
 
-- 
2.1.4



