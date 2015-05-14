From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 14 May 2015 01:06:59 +0000
Subject: [PATCH 30/31] ARM: shmobile: r8a7791: add USB-DMAC device nodes
Message-Id: <e3e25edc1116ebf44b1813aff03b02b7737d41ca.1431565427.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 30e1e13a228f..754c3f20f224 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -358,6 +358,28 @@
 		dma-channels = <13>;
 	};
 
+	usb_dmac0: dma-controller@e65a0000 {
+		compatible = "renesas,usb-dmac";
+		reg = <0 0xe65a0000 0 0x100>;
+		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
+			      0 109 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "ch0", "ch1";
+		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC0>;
+		#dma-cells = <1>;
+		dma-channels = <2>;
+	};
+
+	usb_dmac1: dma-controller@e65b0000 {
+		compatible = "renesas,usb-dmac";
+		reg = <0 0xe65b0000 0 0x100>;
+		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
+			      0 110 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "ch0", "ch1";
+		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC1>;
+		#dma-cells = <1>;
+		dma-channels = <2>;
+	};
+
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
-- 
2.1.4

