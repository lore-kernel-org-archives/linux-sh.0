From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 11:06:01 +0000
Subject: [PATCH/RFC] ARM: shmobile: only enable used I2C interfaces in DT on all Renesas boards
Message-Id: <Pine.LNX.4.64.1309261259490.11968@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Currently all I2C interfaces in all *.dtsi files for various Renesas SoCs
are enabled by default. Switch them all off and only enable populated I2C
interfaces in board-specific *.dts files.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

RFC because this can break things. E.g. if someone relied on an I2C bus 
being available and used it from the user-space. Otherwise I don't think 
it should break anything. Compile-tested all affected .dtb, run-time 
tested on kzm9g.

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |    1 +
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |    1 +
 arch/arm/boot/dts/r8a73a4.dtsi                     |    9 +++++++++
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    1 +
 arch/arm/boot/dts/r8a7740.dtsi                     |    2 ++
 arch/arm/boot/dts/r8a7779.dtsi                     |    4 ++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |    2 ++
 arch/arm/boot/dts/sh73a0.dtsi                      |    5 +++++
 8 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 2b49b05..9443e93 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -62,6 +62,7 @@
 };
 
 &i2c5 {
+	status = "okay";
 	vdd_dvfs: max8973@1b {
 		compatible = "maxim,max8973";
 		reg = <0x1b>;
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 72f867e..91436b5 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -52,6 +52,7 @@
 };
 
 &i2c5 {
+	status = "okay";
 	vdd_dvfs: max8973@1b {
 		compatible = "maxim,max8973";
 		reg = <0x1b>;
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 658fcc5..6048825 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -93,6 +93,7 @@
 		reg = <0 0xe6500000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 174 0x4>;
+		status = "disabled";
 	};
 
 	i2c1: i2c@e6510000 {
@@ -102,6 +103,7 @@
 		reg = <0 0xe6510000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 175 0x4>;
+		status = "disabled";
 	};
 
 	i2c2: i2c@e6520000 {
@@ -111,6 +113,7 @@
 		reg = <0 0xe6520000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 176 0x4>;
+		status = "disabled";
 	};
 
 	i2c3: i2c@e6530000 {
@@ -120,6 +123,7 @@
 		reg = <0 0xe6530000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 177 0x4>;
+		status = "disabled";
 	};
 
 	i2c4: i2c@e6540000 {
@@ -129,6 +133,7 @@
 		reg = <0 0xe6540000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 178 0x4>;
+		status = "disabled";
 	};
 
 	i2c5: i2c@e60b0000 {
@@ -138,6 +143,7 @@
 		reg = <0 0xe60b0000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 179 0x4>;
+		status = "disabled";
 	};
 
 	i2c6: i2c@e6550000 {
@@ -147,6 +153,7 @@
 		reg = <0 0xe6550000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 184 0x4>;
+		status = "disabled";
 	};
 
 	i2c7: i2c@e6560000 {
@@ -156,6 +163,7 @@
 		reg = <0 0xe6560000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 185 0x4>;
+		status = "disabled";
 	};
 
 	i2c8: i2c@e6570000 {
@@ -165,6 +173,7 @@
 		reg = <0 0xe6570000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 173 0x4>;
+		status = "disabled";
 	};
 
 	mmcif0: mmcif@ee200000 {
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 801442b..8b2aab5 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -62,6 +62,7 @@
 };
 
 &i2c0 {
+	status = "okay";
 	touchscreen: st1232@55 {
 		compatible = "sitronix,st1232";
 		reg = <0x55>;
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 44d3d52..868bdde 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -131,6 +131,7 @@
 			      0 202 0x4
 			      0 203 0x4
 			      0 204 0x4>;
+		status = "disabled";
 	};
 
 	i2c1: i2c@e6c20000 {
@@ -143,6 +144,7 @@
 			      0 71 0x4
 			      0 72 0x4
 			      0 73 0x4>;
+		status = "disabled";
 	};
 
 	pfc: pfc@e6050000 {
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index ebbe507..912b3a0 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -156,6 +156,7 @@
 		reg = <0xffc70000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 79 0x4>;
+		status = "disabled";
 	};
 
 	i2c1: i2c@ffc71000 {
@@ -165,6 +166,7 @@
 		reg = <0xffc71000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 82 0x4>;
+		status = "disabled";
 	};
 
 	i2c2: i2c@ffc72000 {
@@ -174,6 +176,7 @@
 		reg = <0xffc72000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 80 0x4>;
+		status = "disabled";
 	};
 
 	i2c3: i2c@ffc73000 {
@@ -183,6 +186,7 @@
 		reg = <0xffc73000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 0x4>;
+		status = "disabled";
 	};
 
 	pfc: pfc@fffc0000 {
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 2122306..8ee06dd 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -108,6 +108,7 @@
 };
 
 &i2c0 {
+	status = "okay";
 	as3711@40 {
 		compatible = "ams,as3711";
 		reg = <0x40>;
@@ -183,6 +184,7 @@
 &i2c3 {
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
+	status = "okay";
 };
 
 &mmcif {
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 3955c76..fcf2688 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -135,6 +135,7 @@
 			      0 168 0x4
 			      0 169 0x4
 			      0 170 0x4>;
+		status = "disabled";
 	};
 
 	i2c1: i2c@e6822000 {
@@ -147,6 +148,7 @@
 			      0 52 0x4
 			      0 53 0x4
 			      0 54 0x4>;
+		status = "disabled";
 	};
 
 	i2c2: i2c@e6824000 {
@@ -159,6 +161,7 @@
 			      0 172 0x4
 			      0 173 0x4
 			      0 174 0x4>;
+		status = "disabled";
 	};
 
 	i2c3: i2c@e6826000 {
@@ -171,6 +174,7 @@
 			      0 184 0x4
 			      0 185 0x4
 			      0 186 0x4>;
+		status = "disabled";
 	};
 
 	i2c4: i2c@e6828000 {
@@ -183,6 +187,7 @@
 			      0 188 0x4
 			      0 189 0x4
 			      0 190 0x4>;
+		status = "disabled";
 	};
 
 	mmcif: mmcif@e6bd0000 {
-- 
1.7.2.5

