From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 26 Apr 2013 16:27:44 +0000
Subject: [PATCH 3/6] ARM: shmobile: sh73a0: remove "0x" prefix from DT node names
Message-Id: <1366993667-23294-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1366993667-23294-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The convention for Device Tree node names is <device>@<hex-address>, where
the part after '@' shouldn't contain the "0x" prefix. Fix the sh73a0.dtsi
DT names.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0.dtsi |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 039205c..eaa9171 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -155,7 +155,7 @@
 		dma-requests = <256>;
 	};
 
-	i2c0: i2c@0xe6820000 {
+	i2c0: i2c@e6820000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -167,7 +167,7 @@
 			      0 170 0x4>;
 	};
 
-	i2c1: i2c@0xe6822000 {
+	i2c1: i2c@e6822000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -179,7 +179,7 @@
 			      0 54 0x4>;
 	};
 
-	i2c2: i2c@0xe6824000 {
+	i2c2: i2c@e6824000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -191,7 +191,7 @@
 			      0 174 0x4>;
 	};
 
-	i2c3: i2c@0xe6826000 {
+	i2c3: i2c@e6826000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -203,7 +203,7 @@
 			      0 186 0x4>;
 	};
 
-	i2c4: i2c@0xe6828000 {
+	i2c4: i2c@e6828000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,rmobile-iic";
@@ -226,7 +226,7 @@
 		renesas,event-quality = <3>;
 	};
 
-	mmcif: mmcif@0x10010000 {
+	mmcif: mmcif@e6bd0000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xe6bd0000 0x100>;
 		interrupt-parent = <&gic>;
@@ -236,7 +236,7 @@
 		status = "disabled";
 	};
 
-	sdhi0: sdhi@0xee100000 {
+	sdhi0: sdhi@ee100000 {
 		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee100000 0x100>;
 		interrupt-parent = <&gic>;
@@ -248,7 +248,7 @@
 	};
 
 	/* SDHI1 and SDHI2 have no CD pins, no need for CD IRQ */
-	sdhi1: sdhi@0xee120000 {
+	sdhi1: sdhi@ee120000 {
 		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee120000 0x100>;
 		interrupt-parent = <&gic>;
@@ -259,7 +259,7 @@
 		status = "disabled";
 	};
 
-	sdhi2: sdhi@0xee140000 {
+	sdhi2: sdhi@ee140000 {
 		compatible = "renesas,r8a7740-sdhi";
 		reg = <0xee140000 0x100>;
 		interrupt-parent = <&gic>;
-- 
1.7.2.5

