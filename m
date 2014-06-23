From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:28:31 +0000
Subject: [PATCH 22/29] ARM: shmobile: r8a7790: Add default PCIe bus clock
Message-Id: <51d17918077215cd93d78a2b13a3b57090eb1f3d.1403487225.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Phil Edworthy <phil.edworthy@renesas.com>

This patch adds a default PCIe bus clock node.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 9df5712..2c55c4b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -487,6 +487,15 @@
 			clock-output-names = "extal";
 		};
 
+		/* External PCIe clock - can be overridden by the board */
+		pcie_bus_clk: pcie_bus_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+			clock-output-names = "pcie_bus";
+			status = "disabled";
+		};
+
 		/*
 		 * The external audio clocks are configured as 0 Hz fixed frequency clocks by
 		 * default. Boards that provide audio clocks should override them.
-- 
2.0.0.rc2

