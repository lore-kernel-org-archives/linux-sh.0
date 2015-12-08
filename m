From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 08 Dec 2015 05:51:51 +0000
Subject: [PATCH 2/2] usb: renesas_usbhs: add device tree support for r8a779[23]
Message-Id: <1449553911-21412-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Simply document new compatibility string.
As a previous patch adds a generic R-Car Gen2 compatibility string
there appears to be no need for a driver updates.

Also add names for SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index 8c50df8441c9..b31f036d2171 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -2,10 +2,12 @@ Renesas Electronics USBHS driver
 
 Required properties:
   - compatible: "renesas,usbhs-<soctype>", "renesas,rcar-usbhs" as fallback.
-	- "renesas,usbhs-r8a7790"
-	- "renesas,usbhs-r8a7791"
-	- "renesas,usbhs-r8a7794"
-	- "renesas,usbhs-r8a7795"
+	- "renesas,usbhs-r8a7790" (R-Car H2)
+	- "renesas,usbhs-r8a7791" (R-Car M2-W)
+	- "renesas,usbhs-r8a7792" (R-Car V2H)
+	- "renesas,usbhs-r8a7793" (R-Car M2-N)
+	- "renesas,usbhs-r8a7794" (R-Car E2)
+	- "renesas,usbhs-r8a7795" (R-Car H3)
   - reg: Base address and length of the register for the USBHS
   - interrupts: Interrupt specifier for the USBHS
   - clocks: A list of phandle + clock specifier pairs
-- 
2.1.4

