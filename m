From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Dec 2015 15:51:39 +0000
Subject: [PATCH 9/9] arm64: renesas: r8a7795: add internal delay for i2c IPs
Message-Id: <1449157899-6572-10-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 56d6a5b23a4e38..b02a7ad1583933 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -519,6 +519,7 @@
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
@@ -530,6 +531,7 @@
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
@@ -541,6 +543,7 @@
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
@@ -552,6 +555,7 @@
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
@@ -563,6 +567,7 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
@@ -574,6 +579,7 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
@@ -585,6 +591,7 @@
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 918>;
 			power-domains = <&cpg>;
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-- 
2.1.4

