From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 02 Dec 2015 22:23:03 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: add EtherAVB DT support
Message-Id: <4724934.jfARgmuogC@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2926317.Iq110C4Bmk@wasted.cogentembedded.com>
In-Reply-To: <2926317.Iq110C4Bmk@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the generic R8A7791 part of the EtherAVB device node. 

Based on the commit f25d6b977240 ("ARM: shmobile: r8a7790: add EtherAVB DT
support").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7791.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -785,6 +785,18 @@
 		status = "disabled";
 	};
 
+	avb: ethernet@e6800000 {
+		compatible = "renesas,etheravb-r8a7791",
+			     "renesas,etheravb-rcar-gen2";
+		reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+		interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7791_CLK_ETHERAVB>;
+		power-domains = <&cpg_clocks>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sata0: sata@ee300000 {
 		compatible = "renesas,sata-r8a7791";
 		reg = <0 0xee300000 0 0x2000>;

