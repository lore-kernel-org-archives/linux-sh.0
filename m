From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:32:12 +0000
Subject: [PATCH 2/4 v2] ARM: shmobile: r8a7778: add renesas_intc_irqpin support on DTSI
Message-Id: <87fvskysxj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txk3up0q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txk3up0q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm/boot/dts/r8a7778.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 3577aba..a6308a3 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -33,6 +33,25 @@
 		      <0xfe430000 0x100>;
 	};
 
+	/* irqpin: IRQ0 - IRQ3 */
+	irqpin: irqpin@fe78001c {
+		compatible = "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		status = "disabled"; /* default off */
+		reg =	<0xfe78001c 4>,
+			<0xfe780010 4>,
+			<0xfe780024 4>,
+			<0xfe780044 4>,
+			<0xfe780064 4>;
+		interrupt-parent = <&gic>;
+		interrupts =   <0 27 0x4
+				0 28 0x4
+				0 29 0x4
+				0 30 0x4>;
+		sense-bitfield-width = <2>;
+	};
+
 	gpio0: gpio@ffc40000 {
 		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
 		reg = <0xffc40000 0x2c>;
-- 
1.7.9.5

