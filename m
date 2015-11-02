From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 02 Nov 2015 04:31:48 +0000
Subject: [PATCH v6 5/5] arm64: renesas: salvator-x: Setup ethernet0 alias for U-Boot
Message-Id: <1446438708-22433-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446438708-22433-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1446438708-22433-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add an ethernet0 alias for the wired network card so that U-Boot can
find the device-node and add an appropriate "local-mac-address"
property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v6
* New patch
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index d1c2fea8bebc..4bb04982be84 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -18,6 +18,7 @@
 	aliases {
 		serial0 = &scif2;
 		serial1 = &scif1;
+		ethernet0 = &avb;
 	};
 
 	chosen {
-- 
2.1.4

