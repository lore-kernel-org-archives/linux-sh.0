From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2014 10:47:29 +0000
Subject: [PATCH 3/7] ARM: shmobile: r8a7790 dtsi: Add QSPI node
Message-Id: <1392029254-15400-4-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: devicetree@vger.kernel.org
Cc: linux-spi@vger.kernel.org
---
 arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 54ab318af712..16bc116e0df4 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -775,4 +775,16 @@
 				"rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
 	};
+
+	spi: spi@e6b10000 {
+		compatible = "renesas,qspi-r8a7790", "renesas,qspi";
+		reg = <0 0xe6b10000 0 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

