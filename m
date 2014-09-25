From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 25 Sep 2014 16:13:22 +0000
Subject: [PATCH 06/13] ARM: shmobile: armadillo800eva dts: Add chosen/stdout-path
Message-Id: <1411661609-4280-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1411661609-4280-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1411661609-4280-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a stdout-path property so that automatic console selection works
in the absence of a "console=" parameter on the kernel command line.
In addition, this will allow the PM domain code to find the PM domain
for the console device.

Note that we have to keep the "console=ttySC1" parameter in
chosen/bootargs, else we only get console messages on tty0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a prerequisite for working "no_console_suspend" support in
"[PATCH v3 09/13] ARM: shmobile: R-Mobile: Add DT support for PM
domains".
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index effb7b46f13172d5..2703428557fce9fa 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -25,6 +25,7 @@
 
 	chosen {
 		bootargs = "console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		stdout-path = &scifa1;
 	};
 
 	memory {
-- 
1.9.1

