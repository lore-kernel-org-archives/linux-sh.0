From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 17:20:58 +0000
Subject: [PATCH v2 3/5] ARM: shmobile: r8a7790: add I2C DT nodes
Message-Id: <1380216060-14506-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1380216060-14506-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1380216060-14506-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Add DT nodes for the four I2C interfacces on r8a7790.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: part two of former [PATCH 2/4], set i2c bus status to "disabled" by
default.

 arch/arm/boot/dts/r8a7790.dtsi |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 28fc18c..ee845fa 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -176,6 +176,46 @@
 		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
 	};
 
+	i2c0: i2c@e6508000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7790";
+		reg = <0 0xe6508000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 287 0x4>;
+		status = "disabled";
+	};
+
+	i2c1: i2c@e6518000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7790";
+		reg = <0 0xe6518000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 288 0x4>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7790";
+		reg = <0 0xe6530000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 286 0x4>;
+		status = "disabled";
+	};
+
+	i2c3: i2c@e6540000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7790";
+		reg = <0 0xe6540000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 290 0x4>;
+		status = "disabled";
+	};
+
 	mmcif0: mmcif@ee200000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-- 
1.7.2.5

