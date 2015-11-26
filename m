From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Nov 2015 22:59:15 +0000
Subject: [RFC 7/9] ARM: shmobile: r8a7791: dtsi: add internal delay for i2c IPs
Message-Id: <1448578757-12613-8-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d79102c0e7d346..57b806f8c28fad 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -408,6 +408,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c1: i2c@e6518000 {
@@ -419,6 +420,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c2: i2c@e6530000 {
@@ -430,6 +432,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c3: i2c@e6540000 {
@@ -441,6 +444,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c4: i2c@e6520000 {
@@ -452,6 +456,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c5: i2c@e6528000 {
@@ -464,6 +469,7 @@
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <110>;
 	};
 
 	i2c6: i2c@e60b0000 {
-- 
2.1.4

