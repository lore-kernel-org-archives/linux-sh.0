From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 17:40:15 +0000
Subject: [PATCH v3 8/9] ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
Message-Id: <1414345216-14486-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add references to the transmit and receive DMA channels in the four
SDHI nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index b800284b9195..3dc942d96348 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -424,6 +424,8 @@
 		reg = <0 0xee100000 0 0x200>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
+		dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
+		dma-names = "tx", "rx";
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -433,6 +435,8 @@
 		reg = <0 0xee120000 0 0x200>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
+		dmas = <&dmac0 0xc9>, <&dmac0 0xca>;
+		dma-names = "tx", "rx";
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -442,6 +446,8 @@
 		reg = <0 0xee140000 0 0x100>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
+		dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
+		dma-names = "tx", "rx";
 		cap-sd-highspeed;
 		status = "disabled";
 	};
@@ -451,6 +457,8 @@
 		reg = <0 0xee160000 0 0x100>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
+		dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
+		dma-names = "tx", "rx";
 		cap-sd-highspeed;
 		status = "disabled";
 	};
-- 
2.0.4

