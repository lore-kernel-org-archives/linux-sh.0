From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 20 Jan 2015 12:51:42 +0000
Subject: [PATCH 5/9] ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
Message-Id: <1421758306-24838-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a node for the Bus State Controller (BSC) on r8a73a4, to which
multiple external devices can be connected.

The BSC is driven by the ZB clock, and located in PM domain C4.
A reference to the latter will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
v3:
  - Add Tested-by,
  - Move "ranges" before "reg",

v2:
  - New.
---
 arch/arm/boot/dts/r8a73a4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index fdcca5d0fb61f0bc..6e59602307e14d8b 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -409,6 +409,15 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	bsc: bus@fec10000 {
+		compatible = "renesas,bsc-r8a73a4", "renesas,bsc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x20000000>;
+		reg = <0 0xfec10000 0 0x400>;
+		clocks = <&zb_clk>;
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.9.1

