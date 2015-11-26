From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Nov 2015 22:59:16 +0000
Subject: [RFC 8/9] ARM: shmobile: r8a7794: dtsi: add internal delay for i2c IPs
Message-Id: <1448578757-12613-9-git-send-email-wsa@the-dreams.de>
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
 arch/arm/boot/dts/r8a7794.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 018ff56470b6da..a6a97c2197c814 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -520,6 +520,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c1: i2c@e6518000 {
@@ -531,6 +532,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c2: i2c@e6530000 {
@@ -542,6 +544,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c3: i2c@e6540000 {
@@ -553,6 +556,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c4: i2c@e6520000 {
@@ -564,6 +568,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c5: i2c@e6528000 {
@@ -575,6 +580,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	mmcif0: mmc@ee200000 {
-- 
2.1.4

