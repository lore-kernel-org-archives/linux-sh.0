From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Dec 2015 04:51:50 +0000
Subject: [PATCH v4 1/3] usb: renesas_usbhs: add SoC names to compatibility string documentation
Message-Id: <1450241512-24699-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450241512-24699-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450241512-24699-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

This extends the documentation of compatibility strings a little to
include the SoC names.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

---
v3
* Split into separate patch
---
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index 7d48f63db44e..a14c0bb561d5 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -2,10 +2,10 @@ Renesas Electronics USBHS driver
 
 Required properties:
   - compatible: Must contain one of the following:
-	- "renesas,usbhs-r8a7790"
-	- "renesas,usbhs-r8a7791"
-	- "renesas,usbhs-r8a7794"
-	- "renesas,usbhs-r8a7795"
+	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
+	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
+	- "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
+	- "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
   - reg: Base address and length of the register for the USBHS
   - interrupts: Interrupt specifier for the USBHS
   - clocks: A list of phandle + clock specifier pairs
-- 
2.1.4

