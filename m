From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:36:59 +0000
Subject: [PATCH 3/7] ARM: shmobile: r8a7778: add R-Car sound support on DTSI
Message-Id: <874n2mdhco.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds R-Car sound support on DTSI.
R-Car sound driver requests SRU/SSI/ADG clocks,
but, r8a7778 still doesn't support common clock yet.
So, it can't probe without local hack at this point.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778.dtsi |   54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 3c6fab5..2581c70 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -232,4 +232,58 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	rcar_sound: rcar_sound@0xffd90000 {
+		#sound-dai-cells = <1>;
+		compatible =  "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1", "renesas,rcar_sound";
+		interrupt-parent = <&gic>;
+		reg =	<0xffd90000 0x1000>, /* SRU */
+			<0xfffe0000 0x100>,  /* ADG */
+			<0xffd91000 0x1240>; /* SSI */
+
+		status = "disabled";
+
+		rcar_sound,src {
+			src0: src@0 { };
+			src1: src@1 { };
+			src2: src@2 { };
+			src3: src@3 { };
+			src4: src@4 { };
+			src5: src@5 { };
+			src6: src@6 { };
+			src7: src@7 { };
+			src8: src@8 { };
+		};
+
+		rcar_sound,ssi {
+			ssi0: ssi@0 {
+				interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi1: ssi@1 {
+				interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi2: ssi@2 {
+				interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi3: ssi@3 {
+				interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi4: ssi@4 {
+				interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi5: ssi@5 {
+				interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi6: ssi@6 {
+				interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi7: ssi@7 {
+				interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+			};
+			ssi8: ssi@8 {
+				interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
+
 };
-- 
1.7.9.5

