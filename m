From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 09:27:07 +0000
Subject: [PATCH 09/17 v6][RFC] arm64: renesas: r8a7795: enable PFC
Message-Id: <87a8tmb9f6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v6

 - new patch

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 7bf9f56..4bacdf1 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -99,6 +99,11 @@
 					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 		};
 
+		pfc: pfc@e6060000 {
+			compatible = "renesas,pfc-r8a7795";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
 		scif2: serial@e6e88000 {
 			compatible = "renesas,scif-r8a7795", "renesas,scif";
 			reg = <0 0xe6e88000 0 64>;
-- 
1.9.1

