From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 01 Sep 2015 15:12:39 +0000
Subject: [PATCH 4/6] arm64: renesas: r8a7795 dtsi: Add device node for RST module
Message-Id: <1441120361-1232-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a device node for the RST module, which provides reset control.
Declare it to be a system controller (syscon), so other device nodes can
refer to its registers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 4bbf6269c035ec4a..05de9810aef0d569 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -410,6 +410,11 @@
 			reg = <0 0xe6060000 0 0x50c>;
 		};
 
+		rst: reset-controller@e6160000 {
+			compatible = "renesas,rst-r8a7795", "syscon";
+			reg = <0 0xe6160000 0 0x0200>;
+		};
+
 		dmac0: dma-controller@e6700000 {
 			/* Empty node for now */
 		};
-- 
1.9.1

