From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Sun, 17 May 2015 00:29:34 +0000
Subject: [PATCH 5/6] ARM: shmobile: lager: Set sdhi and mmcif clock rates
Message-Id: <1431822574.4222.172.camel@xylophone.i.decadent.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
In-Reply-To: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>

From: Ben Dooks <ben.dooks@codethink.co.uk>

[bwh: Fold in fix from Ian Molton]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index aaa4f258e279..343ec0ccc8df 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -413,6 +413,11 @@
 	vmmc-supply = <&fixedregulator3v3>;
 	bus-width = <8>;
 	non-removable;
+
+	assigned-clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
+	assigned-clock-rates = <97500000>;
+	max-frequency = <50000000>;
+
 	status = "okay";
 };
 
@@ -488,6 +493,9 @@
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
 
+	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+	assigned-clock-rates = <156000000>;
+
 	vmmc-supply = <&vcc_sdhi0>;
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
@@ -498,6 +506,9 @@
 	pinctrl-0 = <&sdhi2_pins>;
 	pinctrl-names = "default";
 
+	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+	assigned-clock-rates = <97500000>;
+
 	vmmc-supply = <&vcc_sdhi2>;
 	vqmmc-supply = <&vccq_sdhi2>;
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
-- 
1.7.10.4




