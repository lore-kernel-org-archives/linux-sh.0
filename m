From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 01:05:20 +0000
Subject: [PATCH 13/29] ARM: shmobile: r8a7793: Add PFC to DT
Message-Id: <c26455c7e3e4dd16caa4788fdd558e5fcee04742.1447981420.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Instantiate PFC device in r8a7793 DT.

Based on similar work for the r8a7791 by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 6c7bae4318c9..4f6480f8845f 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -122,6 +122,12 @@
 		power-domains = <&cpg_clocks>;
 	};
 
+	pfc: pfc@e6060000 {
+		compatible = "renesas,pfc-r8a7793";
+		reg = <0 0xe6060000 0 0x250>;
+		#gpio-range-cells = <3>;
+	};
+
 	scif0: serial@e6e60000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
-- 
2.1.4

