From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 24 Oct 2014 10:44:34 +0000
Subject: [PATCH v5 2/2] ARM: shmobile: lager: enable HS-USB
Message-Id: <1414147474-2348-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414147474-2348-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414147474-2348-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Enable HS-USB device for the Lager board, defining the GPIO that the driver
should check when probing. Since this board doesn't have the OTG ID pin, we
assume that GP5_18 (USB0_PWEN) is an ID pin because it is 1 when the SW5 is
in position 2-3 (meaning USB function) and 0 in other positions.

Note that there will be pinctrl-related error messages if both internal PCI
and HS-USB drivers are enabled but they should be just ignored.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[Sergei: added pin node and prop, moved device node, fixed summary, supplemented
changelog]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index b48173b..e5ade61 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -221,6 +221,11 @@
 		renesas,function = "iic3";
 	};
 
+	hsusb_pins: hsusb {
+		renesas,groups = "usb0_ovc_vbus";
+		renesas,function = "usb0";
+	};
+
 	usb0_pins: usb0 {
 		renesas,groups = "usb0";
 		renesas,function = "usb0";
@@ -431,6 +436,13 @@
 	pinctrl-names = "default";
 };
 
+&hsusb {
+	status = "okay";
+	pinctrl-0 = <&hsusb_pins>;
+	pinctrl-names = "default";
+	renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_HIGH>;
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
1.7.9.5

