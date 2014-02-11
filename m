From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Feb 2014 08:56:48 +0000
Subject: [PATCH 2/2] ARM: shmobile: bockw reference dts: Add SPI FLASH
Message-Id: <1392109008-29941-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1392109008-29941-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392109008-29941-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add Spansion s25fl008k SPI FLASH and MTD partition, based on bockw legacy
board code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
Untested due to lack of hardware

 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 06cda19dac6a..f76f6ec01e19 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -109,4 +109,18 @@
 	pinctrl-0 = <&hspi0_pins>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	flash: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl008k";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+		m25p,fast-read;
+
+		partition@0 {
+			label = "data(spi)";
+			reg = <0x00000000 0x00100000>;
+		};
+	};
 };
-- 
1.7.9.5

