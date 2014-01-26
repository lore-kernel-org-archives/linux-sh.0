From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 26 Jan 2014 16:48:59 +0000
Subject: [PATCH 2/8] pci-rcar-gen2: add initial device tree documentation
Message-Id: <1390754945-28142-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, horms+renesas@verge.net.au

Add initial documentation for the pci-rcar-gen2 driver device tree bindings.
This is not yet complete and needs work on the sub-nodes for the PCI bus.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: horms+renesas@verge.net.au
---
 .../devicetree/bindings/pci/renessas,pci-r8a7790.txt         | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renessas,pci-r8a7790.txt

diff --git a/Documentation/devicetree/bindings/pci/renessas,pci-r8a7790.txt b/Documentation/devicetree/bindings/pci/renessas,pci-r8a7790.txt
new file mode 100644
index 0000000..a6fd432
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renessas,pci-r8a7790.txt
@@ -0,0 +1,12 @@
+Renesas internal AHB to PCI bridge
+
+This is the bridge used internally to connect the USB controllers to the
+AHB.
+
+Required properties:
+ - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC
+ - reg : A list of physical regions to access the device. The first is
+         the operational registers for the OHCI/EHCI controller and the
+	 second region is for the bridge configuration and control registers.
+ - interrupts : interrupt for the device
+ - clocks : The reference to the device clock
-- 
1.8.5.2

