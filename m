From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:29:41 +0000
Subject: [PATCH 11/25] ARM: shmobile: bockw dts: Update console parameters
Message-Id: <f84a9cbb173946754712b366524fc4f5fb744424.1450402264.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Drop the "console=" parameter from the kernel command line, as it's no
longer needed for DT-based platforms.
Add serial port config to chosen/stdout-path.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 158ad94fd4d1..b1aa02599229 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -28,8 +28,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs rw";
-		stdout-path = &scif0;
+		bootargs = "ignore_loglevel ip=dhcp root=/dev/nfs rw";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
2.1.4

