From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:29:40 +0000
Subject: [PATCH 10/25] ARM: shmobile: ape6evm dts: Add serial port config to chosen/stdout-path
Message-Id: <6deac6d0b931825081c5894d186abd1c6ec4c524.1450402264.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 9b7eabd3eba3..590257095700 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -23,7 +23,7 @@
 
 	chosen {
 		bootargs = "ignore_loglevel root=/dev/nfs ip=dhcp rw";
-		stdout-path = &scifa0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory@40000000 {
-- 
2.1.4

