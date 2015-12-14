From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 14 Dec 2015 18:57:29 +0000
Subject: [PATCH v3 20/27] serial: sh-sci: Correct SCIF type on R-Car for BRG
Message-Id: <1450119456-964-21-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The "renesas,scif" compatible value is currently used for the SCIF
variant in all Renesas SoCs of the R-Car family.  However, the variant
used in the R-Car family is not the common "SH-4(A)" variant, but a
derivative with added "Baud Rate Generator for External Clock" (BRG),
which is also present in sh7734.

Use the family-specific SCIF compatible values for R-Car Gen1, Gen2, and
Gen3 SoCs to differentiate.  The "renesas,scif" compatible value can
still be used as a common denominator for SCIF variants with the
"SH-4(A)" register layout (i.e. ignoring the "Serial Extension Mode
Register" (SCEMR) and the new BRG-specific registers).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org
---
v3:
  - Add Acked-by,
  - Use family-specific instead of SoC-specific compatible values.
---
 drivers/tty/serial/sh-sci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5b8504bfd42e9906..a202e4e40b8adafb 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2625,6 +2625,17 @@ static const struct of_device_id of_sci_match[] = {
 		.compatible = "renesas,scif-r7s72100",
 		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH2_SCIF_FIFODATA_REGTYPE),
 	},
+	/* Family-specific types */
+	{
+		.compatible = "renesas,rcar-gen1-scif",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+	}, {
+		.compatible = "renesas,rcar-gen2-scif",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+	}, {
+		.compatible = "renesas,rcar-gen3-scif",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+	},
 	/* Generic types */
 	{
 		.compatible = "renesas,scif",
-- 
1.9.1

