From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 08 Dec 2015 09:37:52 +0000
Subject: [PATCH v2 8/9] ARM: shmobile: r8a7794: dtsi: add internal delay for i2c IPs
Message-Id: <1449567473-2084-9-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7794.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6f2f01914db295..37809b8aae65f9 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -519,6 +519,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -530,6 +531,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -541,6 +543,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -552,6 +555,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -563,6 +567,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -574,6 +579,7 @@
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
-- 
2.1.4

