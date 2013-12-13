From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:05 +0000
Subject: [PATCH 31/69] ARM: shmobile: r8a7778: add I2C support on DTSI
Message-Id: <ae4273ec7b25c8b9c895a4aae31f2fced980b7bf.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index ca88b3b..698809f 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -194,4 +194,44 @@
 		cap-sdio-irq;
 		status = "disabled";
 	};
+
+	i2c0: i2c@ffc70000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc70000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 67 0x4>;
+		status = "disabled";
+	};
+
+	i2c1: i2c@ffc71000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc71000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 78 0x4>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@ffc72000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc72000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 76 0x4>;
+		status = "disabled";
+	};
+
+	i2c3: i2c@ffc73000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7778";
+		reg = <0xffc73000 0x1000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 77 0x4>;
+		status = "disabled";
+	};
 };
-- 
1.8.4

