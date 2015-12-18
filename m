From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:29:39 +0000
Subject: [PATCH 09/25] ARM: shmobile: alt dts: Add serial port config to chosen/stdout-path
Message-Id: <b575f99486b938a1720d961e73ec7aabb259ffd0.1450402264.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 767d9224d6cc..2394e4883786 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -21,7 +21,7 @@
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = &scif2;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@40000000 {
-- 
2.1.4

