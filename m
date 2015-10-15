From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 06:24:00 +0000
Subject: [PATCH v11 5/8] arm64: renesas: r8a7795: enable PFC
Message-Id: <1444890243-6978-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444890243-6978-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add a PFC node for the on-chip r8a7795 pin controller.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Changes since v10:
- None

Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
- None

Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
- Dropped Kconfig TODO - select PINCTRL happens in patch 1
- Added Acked-by from Laurent

Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
- Added changelog

Based on:
 [PATCH 10/25 v7][RFC] arm64: renesas: r8a7795: enable PFC
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 0d7ac639094f..e2cc40fa5aa3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -292,6 +292,11 @@
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
-- 
2.1.4

