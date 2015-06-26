From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Fri, 26 Jun 2015 15:23:50 +0000
Subject: [PATCH v3 5/6] ARM: shmobile: lager: Set clock rates for SDHI
Message-Id: <1435332230.23818.12.camel@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1435332116.23818.7.camel@codethink.co.uk>
In-Reply-To: <1435332116.23818.7.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Set the input clocks to the highest supported speeds.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index aaa4f258e279..5f68e53c58ae 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -488,6 +488,9 @@
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
 
+	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+	assigned-clock-rates = <156000000>;
+
 	vmmc-supply = <&vcc_sdhi0>;
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
@@ -498,6 +501,9 @@
 	pinctrl-0 = <&sdhi2_pins>;
 	pinctrl-names = "default";
 
+	assigned-clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+	assigned-clock-rates = <97500000>;
+
 	vmmc-supply = <&vcc_sdhi2>;
 	vqmmc-supply = <&vccq_sdhi2>;
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
-- 
2.1.4




