From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Sep 2015 00:47:08 +0000
Subject: [PATCH 06/19] ARM: shmobile: marzen: Board specific serial port order
Message-Id: <8025e3ff4ca972a0ca2aa898562670a767f79889.1442536920.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1442536920.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert Marzen to use board-specific serial0 and serial1 instead
of the older shared SoC-specific SCIF index.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 20afea6f06ef..fe396c8d58db 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -19,12 +19,12 @@
 	compatible = "renesas,marzen", "renesas,r8a7779";
 
 	aliases {
-		serial2 = &scif2;
-		serial4 = &scif4;
+		serial0 = &scif2;
+		serial1 = &scif4;
 	};
 
 	chosen {
-		bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on";
+		bootargs = "ignore_loglevel root=/dev/nfs ip=on";
 		stdout-path = &scif2;
 	};
 
-- 
2.1.4

