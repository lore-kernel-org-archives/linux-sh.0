From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 16 Oct 2013 12:06:00 +0000
Subject: [PATCH 1/2] sata_rcar: Adjust and document device tree bindings
Message-Id: <1381925161-16729-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381925161-16729-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381925161-16729-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>

This deprecates the "rcar-sata" compatibility string
and adds the "sata-r8a7779" which complies to the
preferred <unit>-<soc> format for SH-Mobile devices.
The DT bindings are documented.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 15 +++++++++++++++
 drivers/ata/sata_rcar.c                             |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
new file mode 100644
index 0000000..0719115
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -0,0 +1,15 @@
+* Renesas R-Car SATA
+
+Required properties:
+- compatible		: should contain "renesas,sata-r8a7779";
+- reg			: offset and length of the SATA registers;
+- interrupts		: must consist of one interrupt specifier.
+
+Example:
+
+sata: sata@fc600000 {
+	compatible = "renesas,sata-r8a7779";
+	reg = <0xfc600000 0x2000>;
+	interrupt-parent = <&gic>;
+	interrupts = <0 100 0x4>;
+};
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index c2d95e9..a625cc5 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -893,7 +893,8 @@ static const struct dev_pm_ops sata_rcar_pm_ops = {
 #endif
 
 static struct of_device_id sata_rcar_match[] = {
-	{ .compatible = "renesas,rcar-sata", },
+	{ .compatible = "renesas,rcar-sata", },	/* Deprecated */
+	{ .compatible = "renesas,sata-r8a7779", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
-- 
1.8.3.1

