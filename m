From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 29 Oct 2014 04:59:21 +0000
Subject: [PATCH 15/19] ARM: shmobile: henninger dts: Add chosen/stdout-path
Message-Id: <8590e2d742c1687a733a90edc25ab0178d6a66fc.1414556944.git.horms+renesas@verge.net.au>
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

Note that we have to keep the "console=ttySC0,38400" parameter in
chosen/bootargs, else the console will use the default setting of 115200
baud.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index f1b56de..0868899 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -23,6 +23,7 @@
 
 	chosen {
 		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = &scif0;
 	};
 
 	memory@40000000 {
-- 
2.1.1

