From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 Aug 2014 13:03:13 +0000
Subject: [PATCH] ARM: shmobile: koelsch: Remove non-existent i2c6 pinmux
Message-Id: <1407848593-23040-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Gaku Inami <gaku.inami.xw-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

On r8a7791, i2c6 (aka iic3) doesn't need pinmux, but the koelsch dts
refers to non-existent pinmux configuration data:

pinmux core: sh-pfc does not support function i2c6
sh-pfc e6060000.pfc: invalid function i2c6 in map table

Remove it to fix this.

Fixes: commit 1d41f36a68c0f4e9b01d563ce33bab5201858b54 ("ARM: shmobile:
       koelsch dts: Add VDD MPU regulator for DVFS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 7966dace64ce..951a5c55003e 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -275,11 +275,6 @@
 		renesas,function = "msiof0";
 	};
 
-	i2c6_pins: i2c6 {
-		renesas,groups = "i2c6";
-		renesas,function = "i2c6";
-	};
-
 	usb0_pins: usb0 {
 		renesas,groups = "usb0";
 		renesas,function = "usb0";
@@ -477,8 +472,6 @@
 };
 
 &i2c6 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
 	clock-frequency = <100000>;
 
-- 
1.9.1

