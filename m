From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 22 Jul 2013 07:36:21 +0000
Subject: [PATCH 09/11] ARM: shmobile: r8a7790: add MMCIF and SDHI DT templates
Message-Id: <8c9b1aa41853272adf505cc22be541f1eac2f94c.1374478037.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374478037.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This adds DT templates for all MMCIF and SDHI controllers on r8a7790.
They are added with status="disabled". To use them platform-specific
DTs have to enable the required ones.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 339d9b1..9cd8820 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -54,4 +54,58 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
 	};
+
+	mmcif0: mmcif@ee200000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 169 0x4>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	mmcif1: mmcif@ee220000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0 0xee220000 0 0x80>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 170 0x4>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	sdhi0: sdhi@ee100000 {
+		compatible = "renesas,r8a7790-sdhi";
+		reg = <0 0xee100000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 165 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi1: sdhi@ee120000 {
+		compatible = "renesas,r8a7790-sdhi";
+		reg = <0 0xee120000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 166 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi2: sdhi@ee140000 {
+		compatible = "renesas,r8a7790-sdhi";
+		reg = <0 0xee140000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi3: sdhi@ee160000 {
+		compatible = "renesas,r8a7790-sdhi";
+		reg = <0 0xee160000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 168 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
 };
-- 
1.8.2.1

