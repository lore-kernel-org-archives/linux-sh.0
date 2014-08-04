From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 04 Aug 2014 10:47:55 +0000
Subject: [PATCH v2 1/2] usb: renesas_usbhs: Add device tree bindings documentation
Message-Id: <53DF64DB.7000206@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Document the device tree bindings for the Renesas USBHS controller.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/usb/renesas_usbhs.txt      |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas_usbhs.txt

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
new file mode 100644
index 0000000..b08c903
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -0,0 +1,24 @@
+Renesas Electronics USBHS driver
+
+Required properties:
+  - compatible: Must contain one of the following:
+	- "renesas,usbhs-r8a7790"
+	- "renesas,usbhs-r8a7791"
+  - reg: Base address and length of the register for the USBHS
+  - interrupts: Interrupt specifier for the USBHS
+  - clocks: A list of phandle + clock specifier pairs
+
+Optional properties:
+  - renesas,buswait: Integer to use BUSWAIT register
+  - renesas,enable-gpio: A gpio specifier to check GPIO determining if USB
+			 function should be enabled
+  - phys: phandle + phy specifier pair
+  - phy-names: must be "usb"
+
+Example:
+	usbhs: usb@e6590000 {
+		compatible = "renesas,usbhs-r8a7790";
+		reg = <0 0xe6590000 0 0x100>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+	};
-- 
1.7.9.5

