From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 26 Jan 2014 16:49:01 +0000
Subject: [PATCH 4/8] ARM: shmobile: lager.dts: add pci 0/1/2
Message-Id: <1390754945-28142-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390754945-28142-1-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Enable pci1 and pci2 nodes for USB controllers attached to the AHB<>PCI
bridge devices. Node pci0 is enabled for the moment as a device, but
could be switched to usb-gadget mode later.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Cc: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 57569cb..8dfcd25 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -80,6 +80,22 @@
 		renesas,groups = "mmc1_data8", "mmc1_ctrl";
 		renesas,function = "mmc1";
 	};
+
+	usb0_pins: usb0 {
+		renesas,groups = "usb0";
+		renesas,function = "usb";
+	};
+
+	usb1_pins: usb1 {
+		renesas,groups = "usb1";
+		renesas,function = "usb";
+	};
+
+	usb2_pins: usb2 {
+		renesas,groups = "usb2";
+		renesas,function = "usb";
+	};
+
 };
 
 &mmcif1 {
@@ -91,3 +107,21 @@
 	non-removable;
 	status = "okay";
 };
+
+&pci0 {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+};
+
+&pci1 {
+	status = "okay";
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+};
+
+&pci2 {
+	status = "okay";
+	pinctrl-0 = <&usb2_pins>;
+	pinctrl-names = "default";
+};
-- 
1.8.5.2

