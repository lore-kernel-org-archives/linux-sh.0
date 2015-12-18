From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:42:38 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7791: use fallback pci compatibility string
Message-Id: <1450406559-9076-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use recently added fallback compatibility string in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 2a369ddcb6fd..d38fb239f286 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1494,7 +1494,7 @@
 	};
 
 	pci0: pci@ee090000 {
-		compatible = "renesas,pci-r8a7791";
+		compatible = "renesas,pci-r8a7791", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
@@ -1529,7 +1529,7 @@
 	};
 
 	pci1: pci@ee0d0000 {
-		compatible = "renesas,pci-r8a7791";
+		compatible = "renesas,pci-r8a7791", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
-- 
2.1.4

