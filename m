From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 Jan 2015 11:13:00 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a73a4 dtsi: Add memory-controller nodes
Message-Id: <1421233982-15883-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add device nodes for the two DDR Bus State Controllers (DBSC).
The DBSCs are located in the A3BC PM domain, which must not be powered
down, else the system will crash.

A reference to the A3BC PM domain will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 6291a57fe8bf440f..424c189640812c91 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -38,6 +38,16 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	dbsc1: memory-controller@e6790000 {
+		compatible = "renesas,dbsc-r8a73a4";
+		reg = <0 0xe6790000 0 0x10000>;
+	};
+
+	dbsc2: memory-controller@e67a0000 {
+		compatible = "renesas,dbsc-r8a73a4";
+		reg = <0 0xe67a0000 0 0x10000>;
+	};
+
 	dmac: dma-multiplexer {
 		compatible = "renesas,shdma-mux";
 		#dma-cells = <1>;
-- 
1.9.1

