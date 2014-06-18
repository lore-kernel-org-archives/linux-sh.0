From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 09:14:07 +0000
Subject: [PROTOTYPE 03/10] ARM: shmobile: r8a7790: add Audio DMAC entry for sound on DTSI
Message-Id: <8761jyy3z3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi |   44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 493762d..2c339fa 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1124,6 +1124,50 @@
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 
+		dmas =		<&dma1 0x01 CHCR_TX_32BIT>,	<&dma1 0x02 CHCR_RX_32BIT>,	<&dma1 0x15 CHCR_TX_32BIT>,	<&dma1 0x16 CHCR_RX_32BIT>,
+				<&dma1 0x03 CHCR_TX_32BIT>,	<&dma1 0x04 CHCR_RX_32BIT>,	<&dma1 0x49 CHCR_TX_32BIT>,	<&dma1 0x4a CHCR_RX_32BIT>,
+				<&dma1 0x05 CHCR_TX_32BIT>,	<&dma1 0x06 CHCR_RX_32BIT>,	<&dma1 0x63 CHCR_TX_32BIT>,	<&dma1 0x64 CHCR_RX_32BIT>,
+				<&dma1 0x07 CHCR_TX_32BIT>,	<&dma1 0x08 CHCR_RX_32BIT>,	<&dma1 0x6f CHCR_TX_32BIT>,	<&dma1 0x70 CHCR_RX_32BIT>,
+				<&dma1 0x09 CHCR_TX_32BIT>,	<&dma1 0x0a CHCR_RX_32BIT>,	<&dma1 0x71 CHCR_TX_32BIT>,	<&dma1 0x72 CHCR_RX_32BIT>,
+				<&dma1 0x0b CHCR_TX_32BIT>,	<&dma1 0x0c CHCR_RX_32BIT>,	<&dma1 0x73 CHCR_TX_32BIT>,	<&dma1 0x74 CHCR_RX_32BIT>,
+				<&dma1 0x0d CHCR_TX_32BIT>,	<&dma1 0x0e CHCR_RX_32BIT>,	<&dma1 0x75 CHCR_TX_32BIT>,	<&dma1 0x76 CHCR_RX_32BIT>,
+				<&dma1 0x0f CHCR_TX_32BIT>,	<&dma1 0x10 CHCR_RX_32BIT>,	<&dma1 0x79 CHCR_TX_32BIT>,	<&dma1 0x7a CHCR_RX_32BIT>,
+				<&dma1 0x11 CHCR_TX_32BIT>,	<&dma1 0x12 CHCR_RX_32BIT>,	<&dma1 0x7b CHCR_TX_32BIT>,	<&dma1 0x7c CHCR_RX_32BIT>,
+				<&dma1 0x13 CHCR_TX_32BIT>,	<&dma1 0x14 CHCR_RX_32BIT>,	<&dma1 0x7d CHCR_TX_32BIT>,	<&dma1 0x7e CHCR_RX_32BIT>,
+
+				<&dma1 0x85 CHCR_TX_32BIT>,	<&dma1 0x9a CHCR_RX_32BIT>,	<&dma1 0xbc CHCR_RX_32BIT>,
+				<&dma1 0x87 CHCR_TX_32BIT>,	<&dma1 0x9c CHCR_RX_32BIT>,	<&dma1 0xbe CHCR_RX_32BIT>,
+				<&dma1 0x89 CHCR_TX_32BIT>,	<&dma1 0x9e CHCR_RX_32BIT>,
+				<&dma1 0x8b CHCR_TX_32BIT>,	<&dma1 0xa0 CHCR_RX_32BIT>,
+				<&dma1 0x8d CHCR_TX_32BIT>,	<&dma1 0xb0 CHCR_RX_32BIT>,
+				<&dma1 0x8f CHCR_TX_32BIT>,	<&dma1 0xb2 CHCR_RX_32BIT>,
+				<&dma1 0x91 CHCR_TX_32BIT>,	<&dma1 0xb4 CHCR_RX_32BIT>,
+				<&dma1 0x93 CHCR_TX_32BIT>,	<&dma1 0xb6 CHCR_RX_32BIT>,
+				<&dma1 0x95 CHCR_TX_32BIT>,	<&dma1 0xb8 CHCR_RX_32BIT>,
+				<&dma1 0x97 CHCR_TX_32BIT>,	<&dma1 0xba CHCR_RX_32BIT>;
+
+		dma-names =	"mem_ssi0",			"ssi0_mem",			"mem_ssiu0",			"ssiu0_mem",
+				"mem_ssi1",			"ssi1_mem",			"mem_ssiu1",			"ssiu1_mem",
+				"mem_ssi2",			"ssi2_mem",			"mem_ssiu2",			"ssiu2_mem",
+				"mem_ssi3",			"ssi3_mem",			"mem_ssiu3",			"ssiu3_mem",
+				"mem_ssi4",			"ssi4_mem",			"mem_ssiu4",			"ssiu4_mem",
+				"mem_ssi5",			"ssi5_mem",			"mem_ssiu5",			"ssiu5_mem",
+				"mem_ssi6",			"ssi6_mem",			"mem_ssiu6",			"ssiu6_mem",
+				"mem_ssi7",			"ssi7_mem",			"mem_ssiu7",			"ssiu7_mem",
+				"mem_ssi8",			"ssi8_mem",			"mem_ssiu8",			"ssiu8_mem",
+				"mem_ssi9",			"ssi9_mem",			"mem_ssiu9",			"ssiu9_mem",
+
+				"mem_src0",			"src0_mem",			"dvc0_mem",
+				"mem_src1",			"src1_mem",			"dvc1_mem",
+				"mem_src2",			"src2_mem",
+				"mem_src3",			"src3_mem",
+				"mem_src4",			"src4_mem",
+				"mem_src5",			"src5_mem",
+				"mem_src6",			"src6_mem",
+				"mem_src7",			"src7_mem",
+				"mem_src8",			"src8_mem",
+				"mem_src9",			"src9_mem";
+
 		status = "disabled";
 
 		rcar_sound,dvc {
-- 
1.7.9.5

