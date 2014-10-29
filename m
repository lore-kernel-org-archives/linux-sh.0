From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 29 Oct 2014 04:59:17 +0000
Subject: [PATCH 11/19] ARM: shmobile: armadillo800eva dts: Add chosen/stdout-path
Message-Id: <2c32622c3f3f9c7e0d3480c1fc0a31a95e04dd91.1414556944.git.horms+renesas@verge.net.au>
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
In addition, this will allow the PM domain code to find the PM domain
for the console device.

Note that we have to keep the "console=ttySC1" parameter in
chosen/bootargs, else we only get console messages on tty0, and because
this DTS is shared between legacy and multi-platform.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index effb7b4..2703428 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -25,6 +25,7 @@
 
 	chosen {
 		bootargs = "console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		stdout-path = &scifa1;
 	};
 
 	memory {
-- 
2.1.1

