From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Nov 2014 11:52:09 +0000
Subject: [PATCH 4/5] ARM: shmobile: sh73a0 dtsi: Add SoC-specific IIC compatible properties
Message-Id: <1415274730-310-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415274730-310-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

The IIC nodes used the generic compatible properties only.
This causes the driver to fail when using Standard Speed, as the
operational clock is driven by the 104 MHz HP clock:

    i2c-sh_mobile e6820000.i2c: timing values out of range: L/H=0x208/0x1bf
    i2c-sh_mobile: probe of e6820000.i2c failed with error -22

Add the SoC-specific compatible property to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 030a5920312fa19b..d8def5a529da2882 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -138,7 +138,7 @@
 	i2c0: i2c@e6820000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6820000 0x425>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH
 			      0 168 IRQ_TYPE_LEVEL_HIGH
@@ -150,7 +150,7 @@
 	i2c1: i2c@e6822000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6822000 0x425>;
 		interrupts = <0 51 IRQ_TYPE_LEVEL_HIGH
 			      0 52 IRQ_TYPE_LEVEL_HIGH
@@ -162,7 +162,7 @@
 	i2c2: i2c@e6824000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6824000 0x425>;
 		interrupts = <0 171 IRQ_TYPE_LEVEL_HIGH
 			      0 172 IRQ_TYPE_LEVEL_HIGH
@@ -174,7 +174,7 @@
 	i2c3: i2c@e6826000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6826000 0x425>;
 		interrupts = <0 183 IRQ_TYPE_LEVEL_HIGH
 			      0 184 IRQ_TYPE_LEVEL_HIGH
@@ -186,7 +186,7 @@
 	i2c4: i2c@e6828000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,iic-sh73a0", "renesas,rmobile-iic";
 		reg = <0xe6828000 0x425>;
 		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH
 			      0 188 IRQ_TYPE_LEVEL_HIGH
-- 
1.9.1

