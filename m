From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Wed, 15 Nov 2017 10:55:57 +0000
Subject: [PATCH v1 04/10] ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
Message-Id: <1510743363-25798-5-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, mchehab@kernel.org, hverkuil@xs4all.nl
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Add Capture Engine Unit (CEU) node to device tree.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm/boot/dts/r7s72100.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 4ed12a4..683d459 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -136,8 +136,8 @@
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe042c 4>;
 			clocks = <&p0_clk>;
-			clock-indices = <R7S72100_CLK_RTC>;
-			clock-output-names = "rtc";
+			clock-indices = <R7S72100_CLK_RTC R7S72100_CLK_CEU>;
+			clock-output-names = "rtc", "ceu";
 		};
 
 		mstp7_clks: mstp7_clks@fcfe0430 {
@@ -666,4 +666,12 @@
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
+
+	ceu: ceu@e8210000 {
+		reg = <0xe8210000 0x209c>;
+		compatible = "renesas,renesas-ceu";
+		interrupts = <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
 };
-- 
2.7.4

