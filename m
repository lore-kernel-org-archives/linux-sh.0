From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Nov 2015 22:59:17 +0000
Subject: [RFC 9/9] arm64: renesas: r8a7795: add internal delay for i2c IPs
Message-Id: <1448578757-12613-10-git-send-email-wsa@the-dreams.de>
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
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e786343d97e709..08262402fe606f 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -429,6 +429,7 @@
 			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&cpg>;
 			status = "disabled";
+			i2c-scl-internal-delay-ns = <110>;
 		};
 
 		i2c1: i2c@e6508000 {
@@ -440,6 +441,7 @@
 			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&cpg>;
 			status = "disabled";
+			i2c-scl-internal-delay-ns = <6>;
 		};
 
 		i2c2: i2c@e6510000 {
@@ -451,6 +453,7 @@
 			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&cpg>;
 			status = "disabled";
+			i2c-scl-internal-delay-ns = <6>;
 		};
 
 		i2c3: i2c@e66d0000 {
@@ -462,6 +465,7 @@
 			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&cpg>;
 			status = "disabled";
+			i2c-scl-internal-delay-ns = <110>;
 		};
 
 		i2c4: i2c@e66d8000 {
@@ -473,6 +477,7 @@
 			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&cpg>;
 			status = "disabled";
+			i2c-scl-internal-delay-ns = <110>;
 		};
 
 		i2c5: i2c@e66e0000 {
@@ -484,6 +489,7 @@
 			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&cpg>;
 			status = "disabled";
+			i2c-scl-internal-delay-ns = <110>;
 		};
 
 		i2c6: i2c@e66e8000 {
@@ -495,6 +501,7 @@
 			clocks = <&cpg CPG_MOD 918>;
 			power-domains = <&cpg>;
 			status = "disabled";
+			i2c-scl-internal-delay-ns = <6>;
 		};
 
 		rcar_sound: sound@ec500000 {
-- 
2.1.4

