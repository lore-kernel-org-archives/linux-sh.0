From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 19:56:05 +0000
Subject: [PATCH v2 1/2] ARM: shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module
Message-Id: <1420574166-14979-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This clock drives the irqpin controller modules.
Before, it was assumed enabled by the bootloader or reset state.
By making it available to the driver, we make sure it gets enabled when
needed, and allow it to be managed by system or runtime PM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Rebased. This now depends on "ARM: shmobile: sh73a0 dtsi: Set
    control-parent for all irqpin nodes", which is fix for a crash and
    thus had higher priority.
---
 arch/arm/boot/dts/sh73a0.dtsi            | 15 +++++++++++++++
 include/dt-bindings/clock/sh73a0-clock.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 1cd7b58cb586da6e..ac660c468f38c46a 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -78,6 +78,7 @@
 			      0 6 IRQ_TYPE_LEVEL_HIGH
 			      0 7 IRQ_TYPE_LEVEL_HIGH
 			      0 8 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		control-parent;
 	};
 
@@ -98,6 +99,7 @@
 			      0 14 IRQ_TYPE_LEVEL_HIGH
 			      0 15 IRQ_TYPE_LEVEL_HIGH
 			      0 16 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		control-parent;
 	};
 
@@ -118,6 +120,7 @@
 			      0 22 IRQ_TYPE_LEVEL_HIGH
 			      0 23 IRQ_TYPE_LEVEL_HIGH
 			      0 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		control-parent;
 	};
 
@@ -138,6 +141,7 @@
 			      0 30 IRQ_TYPE_LEVEL_HIGH
 			      0 31 IRQ_TYPE_LEVEL_HIGH
 			      0 32 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks SH73A0_CLK_INTCA0>;
 		control-parent;
 	};
 
@@ -682,5 +686,16 @@
 			clock-output-names  				"iic3", "iic4", "keysc";
 		};
+		mstp5_clks: mstp5_clks@e6150144 {
+			compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150144 4>, <0xe615003c 4>;
+			clocks = <&cpg_clocks SH73A0_CLK_HP>;
+			#clock-cells = <1>;
+			clock-indices = <
+				SH73A0_CLK_INTCA0
+			>;
+			clock-output-names +				"intca0";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/sh73a0-clock.h b/include/dt-bindings/clock/sh73a0-clock.h
index 1dd3eb2b7d902afd..53369568c24c5dc6 100644
--- a/include/dt-bindings/clock/sh73a0-clock.h
+++ b/include/dt-bindings/clock/sh73a0-clock.h
@@ -76,4 +76,7 @@
 #define SH73A0_CLK_IIC4		10
 #define SH73A0_CLK_KEYSC	3
 
+/* MSTP5 */
+#define SH73A0_CLK_INTCA0	8
+
 #endif
-- 
1.9.1

