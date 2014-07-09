From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 09 Jul 2014 12:23:32 +0000
Subject: [PATCH 02/13] irqchip: renesas-intc-irqpin: Document SoC-specific bindings
Message-Id: <1404908623-909-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1404908623-909-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404908623-909-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

The documentation only mentioned the generic fallback compatible property.
Add the missing SoC-specific compatible properties, which are already in
use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 .../bindings/interrupt-controller/renesas,intc-irqpin.txt         | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
index 1f8b0c507c26..c73acd060093 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
@@ -2,7 +2,13 @@ DT bindings for the R-/SH-Mobile irqpin controller
 
 Required properties:
 
-- compatible: has to be "renesas,intc-irqpin"
+- compatible: has to be "renesas,intc-irqpin-<soctype>", "renesas,intc-irqpin"
+  as fallback.
+  Examples with soctypes are:
+    - "renesas,intc-irqpin-r8a7740" (R-Mobile A1)
+    - "renesas,intc-irqpin-r8a7778" (R-Car M1A)
+    - "renesas,intc-irqpin-r8a7779" (R-Car H1)
+    - "renesas,intc-irqpin-sh73a0" (SH-Mobile AG5)
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
   interrupts.txt in this directory
 
-- 
1.9.1

