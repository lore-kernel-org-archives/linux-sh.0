From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 06:30:03 +0000
Subject: [PATCH v8 05/07] arm64: renesas: r8a7795: enable PFC
Message-Id: <20150831063003.24004.42127.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add a PFC node for the on-chip r8a7795 pin controller.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Based on:
  [PATCH 10/25 v7][RFC] arm64: renesas: r8a7795: enable PFC

 Changes: (Magnus Damm <damm+renesas@opensource.se>)
 - Added changelog

 TODO:
 - Add Kconfig select bits
 
 arch/arm64/boot/dts/renesas/r8a7795.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

--- 0012/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-08-29 15:38:44.152366518 +0900
@@ -278,6 +278,11 @@
 			};
 		};
 
+		pfc: pfc@e6060000 {
+			compatible = "renesas,pfc-r8a7795";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
 		dmac0: dma-controller@e6700000 {
 			/* Empty node for now */
 		};
