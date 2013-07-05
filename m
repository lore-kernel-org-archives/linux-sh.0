From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 15:25:31 +0000
Subject: [PATCH v2 5/6] ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
Message-Id: <1373037932-19918-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds DT templates for all MMCIF and SDHI controllers on r8a73a4.
They are added with status="disabled". To use them platform-specific
DTs have to enable the required ones.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2:
1. fixed MMCIF resource sizes
2. added SDHI compatibility with the actual SoC for possible future driver
   extensions

 arch/arm/boot/dts/r8a73a4.dtsi |   45 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4e1ddf0..0238676 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -166,4 +166,49 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 173 0x4>;
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
+		compatible = "renesas,r8a73a4-sdhi", "renesas,r8a7740-sdhi";
+		reg = <0 0xee100000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 165 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi1: sdhi@ee120000 {
+		compatible = "renesas,r8a73a4-sdhi", "renesas,r8a7740-sdhi";
+		reg = <0 0xee120000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 166 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi2: sdhi@ee140000 {
+		compatible = "renesas,r8a73a4-sdhi", "renesas,r8a7740-sdhi";
+		reg = <0 0xee140000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
 };
-- 
1.7.2.5

