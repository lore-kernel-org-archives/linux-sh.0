From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 09 Nov 2015 01:33:18 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7793: Add PFC to DT
Message-Id: <1447032799-13155-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447032799-13155-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447032799-13155-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Instantiate PFC device in r8a7793 DT.

Based on similar work for the r8a7791 by Magnus Damm.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index fcafa87616fa..6597207cd55e 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -114,6 +114,12 @@
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

