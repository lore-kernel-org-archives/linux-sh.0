From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 29 Oct 2014 04:59:22 +0000
Subject: [PATCH 16/19] ARM: shmobile: koelsch dts: Add chosen/stdout-path
Message-Id: <17323b3615b54bd80ba7e9056c62266e7df24f27.1414556944.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a stdout-path property so that automatic console selection works
in the absence of a "console=" parameter on the kernel command line.

Note that we have to keep the "console=" parameter in chosen/bootargs,
as this DTS is shared between legacy and multi-platform.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 07550e7..9497cc2 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -26,6 +26,7 @@
 
 	chosen {
 		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = &scif0;
 	};
 
 	memory@40000000 {
-- 
2.1.1

