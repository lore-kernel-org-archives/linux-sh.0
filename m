From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 03 Oct 2014 15:11:38 +0000
Subject: [PATCH v2 07/13] ARM: shmobile: bockw-reference dts: Add chosen/stdout-path
Message-Id: <1412349104-18724-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a stdout-path property so that automatic console selection works
in the absence of a "console=" parameter on the kernel command line.

Remove the now-superfluous "console=" parameter from chosen/bootargs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 3342c74c5de890b1..fba294905ff42690 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -28,7 +28,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		bootargs = "ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		stdout-path = &scif0;
 	};
 
 	memory {
-- 
1.9.1

