From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 03 Oct 2014 15:11:44 +0000
Subject: [PATCH v2 13/13] ARM: shmobile: kzm9g-reference dts: Add chosen/stdout-path
Message-Id: <1412349104-18724-14-git-send-email-geert+renesas@glider.be>
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
In addition, this will allow the PM domain code to find the PM domain
for the console device.

Note that we have to keep the "console=ttySC4" parameter in
chosen/bootargs, else we only get console messages on tty0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 30ef97e99dc53ea7..0dac0e66ccad8f74 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -40,6 +40,7 @@
 
 	chosen {
 		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel rw";
+		stdout-path = &scifa4;
 	};
 
 	memory {
-- 
1.9.1

