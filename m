From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 19 Nov 2015 18:38:41 +0000
Subject: [PATCH 02/25] serial: sh-sci: Update DT binding documentation for BRG support
Message-Id: <1447958344-836-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Amend the DT bindings to include the optional clock sources for the Baud
Rate Generator for External Clock (BRG), as found on some SCIF variants
and on HSCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 8efc9b6f35637fbb..ae907e39b11c2a5a 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -46,6 +46,12 @@ Required properties:
     On (H)SCI(F) and some SCIFA, an additional clock may be specified:
       - "hsck" for the optional external clock input (on HSCIF),
       - "sck" for the optional external clock input (on other variants).
+    On UARTs equipped with a Baud Rate Generator for External Clock (BRG)
+    (some SCIF and HSCIF), additional clocks may be specified:
+      - "int_clk" for the optional internal clock source for the frequency
+	divider (typically the (AXI or SHwy) bus clock),
+      - "scif_clk" for the optional external clock source for the frequency
+	divider (SCIF_CLK).
 
 Note: Each enabled SCIx UART should have an alias correctly numbered in the
 "aliases" node.
-- 
1.9.1

