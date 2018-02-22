From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Thu, 22 Feb 2018 10:37:20 +0000
Subject: [PATCH v11 04/10] ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
Message-Id: <1519295846-11612-5-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1519295846-11612-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1519295846-11612-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, hverkuil@xs4all.nl, mchehab@kernel.org, festevam@gmail.com, sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com, pombredanne@nexb.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Add Capture Engine Unit (CEU) node to device tree.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 arch/arm/boot/dts/r7s72100.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index ab9645a..23e05ce 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -135,9 +135,9 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe042c 4>;
-			clocks = <&p0_clk>;
-			clock-indices = <R7S72100_CLK_RTC>;
-			clock-output-names = "rtc";
+			clocks = <&b_clk>, <&p0_clk>;
+			clock-indices = <R7S72100_CLK_CEU R7S72100_CLK_RTC>;
+			clock-output-names = "ceu", "rtc";
 		};
 
 		mstp7_clks: mstp7_clks@fcfe0430 {
@@ -667,4 +667,13 @@
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
+
+	ceu: camera@e8210000 {
+		reg = <0xe8210000 0x3000>;
+		compatible = "renesas,r7s72100-ceu";
+		interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp6_clks R7S72100_CLK_CEU>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
 };
-- 
2.7.4

