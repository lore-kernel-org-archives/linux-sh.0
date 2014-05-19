From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 19 May 2014 10:08:19 +0000
Subject: [PATCH 3/3] Documentation: dt-bindings: update xhci-platform DT binding for R-Car H2 and M2
Message-Id: <5379D813.1040100@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathias.nyman@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

This commit extends the compatible string list of the xhci-platform
binding with the new "renesas,r8a7790-xhci" and "renesas,r8a7791-xhci"
compatible strings. It is used to describe the xHCI controller which
is available in the R-Car H2 and M2 SoCs.
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 999be5c..e3107bb 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -2,7 +2,8 @@ USB xHCI controllers

 Required properties:
   - compatible: should be one of "generic-xhci",
-    "marvell,armada-375-xhci", "marvell,armada-380-xhci" (deprecated:
+    "marvell,armada-375-xhci", "marvell,armada-380-xhci",
+    "renesas,r8a7790-xhci", "renesas,r8a7791-xhci" (deprecated:
     "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
-- 
1.7.9.5
