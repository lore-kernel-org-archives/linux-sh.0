From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 01 Nov 2013 01:22:21 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7778: add HSPI suppport on DTSI
Message-Id: <871u30zzjp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778.dtsi |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 698809f..819b194 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -25,6 +25,12 @@
 		};
 	};
 
+	aliases {
+		spi0 = &hspi0;
+		spi1 = &hspi1;
+		spi2 = &hspi2;
+	};
+
 	gic: interrupt-controller@fe438000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
@@ -234,4 +240,28 @@
 		interrupts = <0 77 0x4>;
 		status = "disabled";
 	};
+
+	hspi0: spi@fffc7000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc7000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 63 4>;
+		status = "disabled";
+	};
+
+	hspi1: spi@fffc8000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc8000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 84 4>;
+		status = "disabled";
+	};
+
+	hspi2: spi@fffc6000 {
+		compatible = "renesas,hspi";
+		reg = <0xfffc6000 0x18>;
+		interrupt-controller = <&gic>;
+		interrupts = <0 85 4>;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

