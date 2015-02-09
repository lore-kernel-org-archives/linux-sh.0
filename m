From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 09 Feb 2015 08:24:38 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: add USB-DMAC device nodes
Message-Id: <1423470279-6340-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423470279-6340-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1423470279-6340-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index afba8af..9343548 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -364,6 +364,28 @@
 		reg = <0 0xec740000 0 0x200>;
 	};
 
+	usb_dmac0: dma-controller@e65a0000 {
+		compatible = "renesas,usb-dmac";
+		reg = <0 0xe65a0000 0 0x100>;
+		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
+			      0 109 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "ch0", "ch1";
+		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC0>;
+		#dma-cells = <1>;
+		dma-channels = <2>;
+	};
+
+	usb_dmac1: dma-controller@e65b0000 {
+		compatible = "renesas,usb-dmac";
+		reg = <0 0xe65b0000 0 0x100>;
+		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
+			      0 110 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "ch0", "ch1";
+		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC1>;
+		#dma-cells = <1>;
+		dma-channels = <2>;
+	};
+
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
-- 
1.7.9.5

