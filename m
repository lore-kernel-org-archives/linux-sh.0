From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:42:37 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7790: use fallback pci compatibility string
Message-Id: <1450406559-9076-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7dfd393bfc7e..8f2e073ae382 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1476,7 +1476,7 @@
 	};
 
 	pci0: pci@ee090000 {
-		compatible = "renesas,pci-r8a7790";
+		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
@@ -1511,7 +1511,7 @@
 	};
 
 	pci1: pci@ee0b0000 {
-		compatible = "renesas,pci-r8a7790";
+		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		reg = <0 0xee0b0000 0 0xc00>,
 		      <0 0xee0a0000 0 0x1100>;
@@ -1532,7 +1532,7 @@
 	};
 
 	pci2: pci@ee0d0000 {
-		compatible = "renesas,pci-r8a7790";
+		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		device_type = "pci";
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
 		power-domains = <&cpg_clocks>;
-- 
2.1.4

