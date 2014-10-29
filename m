From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 13:58:50 +0000
Subject: [PATCH 2/3] sata_rcar: Document deprecated "renesas,rcar-sata"
Message-Id: <1414591131-21771-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit e67adb4e669db834 ("sata_rcar: Add R-Car Gen2 SATA PHY support")
deprecated "renesas,rcar-sata" in favor of "renesas,sata-r8a7779", but
the deprecated value was never documented in the binding documentation,
while it is still in active use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/ata/sata_rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
index 12d9de915ebd6cbf..ed266c87ce106f20 100644
--- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
+++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible		: should contain one of the following:
 			  - "renesas,sata-r8a7779" for R-Car H1
+			    ("renesas,rcar-sata" is deprecated)
 			  - "renesas,sata-r8a7790" for R-Car H2
 			  - "renesas,sata-r8a7791" for R-Car M2
 - reg			: address and length of the SATA registers;
-- 
1.9.1

