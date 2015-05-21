From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 21 May 2015 10:48:11 +0000
Subject: [PATCH v3 09/11] PCI: rcar: document r8a7793 DT bindings
Message-Id: <1432205293-9488-10-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205293-9488-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205293-9488-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org, horms@verge.net.au, linux-sh@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, kuninori.morimoto.gx@renesas.com
Cc: magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index d8ef5bf..8b156fe 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -8,6 +8,7 @@ OHCI and EHCI controllers.
 Required properties:
 - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
 	      "renesas,pci-r8a7791" for the R8A7791 SoC.
+	      "renesas,pci-r8a7793" for the R8A7793 SoC.
 - reg:	A list of physical regions to access the device: the first is
 	the operational registers for the OHCI/EHCI controllers and the
 	second is for the bridge configuration and control registers.
-- 
2.3.5

