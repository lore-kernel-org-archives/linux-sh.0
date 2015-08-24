From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Aug 2015 02:28:33 +0000
Subject: [PATCH 10/25 v7][RFC] arm64: renesas: r8a7795: enable PFC
Message-Id: <87egit779u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v7

 - new patch

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 150b146..c3421b3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -103,6 +103,11 @@
 			};
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

