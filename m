From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Nov 2014 01:50:47 +0000
Subject: [PATCH 7/7] ARM: shmobile: koelsch dts: Drop console= bootargs parameter
Message-Id: <79e69d179cb3391040a3693fca8bc12ec03c05fc.1415059146.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415059146.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415059146.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Koelsch is now restricted to booting from DT, so chosen/stdout-path is
always used, and we can drop the "console=" parameter from chosen/bootargs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 5e4d833..9241838 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -25,7 +25,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scif0;
 	};
 
-- 
2.1.1

