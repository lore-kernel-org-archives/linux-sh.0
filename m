From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 10:33:17 +0000
Subject: [PATCH v9 05/07][RFC] arm64: renesas: r8a7795: enable PFC
Message-Id: <20150903103317.26791.23151.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add a PFC node for the on-chip r8a7795 pin controller.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
 - Dropped Kconfig TODO - select PINCTRL happens in patch 1
 - Added Acked-by from Laurent

 Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
 - Added changelog

 Based on:
  [PATCH 10/25 v7][RFC] arm64: renesas: r8a7795: enable PFC

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
