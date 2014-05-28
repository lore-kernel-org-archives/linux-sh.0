From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 28 May 2014 11:23:26 +0000
Subject: [PATCH v2 3/3] Documentation: dt-bindings: update xhci-platform DT binding for R-Car H2 and M2
Message-Id: <5385C72E.2050309@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This commit extends the compatible string list of the xhci-platform
binding with the new "renesas,xhci-r8a7790" and "renesas,xhci-r8a7791"
compatible strings. It is used to describe the xHCI controller which
is available in the R-Car H2 and M2 SoCs.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index 999be5c..5a79377 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -2,7 +2,8 @@ USB xHCI controllers

 Required properties:
   - compatible: should be one of "generic-xhci",
-    "marvell,armada-375-xhci", "marvell,armada-380-xhci" (deprecated:
+    "marvell,armada-375-xhci", "marvell,armada-380-xhci",
+    "renesas,xhci-r8a7790", "renesas,xhci-r8a7791" (deprecated:
     "xhci-platform").
   - reg: should contain address and length of the standard XHCI
     register set for the device.
-- 
1.7.9.5
