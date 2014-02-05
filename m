From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 10:19:09 +0000
Subject: [PATCH 06/11] phy-rcar-usb-gen2: add device tree documentation
Message-Id: <1391595554-20640-7-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Documentation for phy-rcar-usb-gen2 device tree binding.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
Cc: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: horms+renesas@verge.net.au
---
 .../bindings/usb/renesas,rcar-gen2-usb-phy.txt           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
new file mode 100644
index 0000000..e1d2dd9
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
@@ -0,0 +1,16 @@
+Renesas RCar gen2 USB PHY bindings
+
+Required properties:
+ - compatible: "renesas,usb-phy-r8a7790" for the R8A7790 SoC or
+    "renesas,rcar-gen2-usb-phy" for any generic comaptible device.
+ - reg : A single region to access device registers
+ - clocks : The reference to the clock to use for this block
+ - clock-names : The name for the clock at index 0 (must be "usbhs")
+
+Note, interrupt is currently not supported by the driver, but there should
+be a node in the device tree for it.
+
+Optional properties:
+
+ - renesas,usb0-hs: boolean, if present USB0 is connected to HS device.
+ - renesas,usb2-ss: boolean, if present USB2 is connected to XHCI controller.
-- 
1.8.5.3

