From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:29:16 +0000
Subject: [PATCH 08/10] arm64: dts: r8a7795: Add SATA controller node
Message-Id: <4c13472b8cc4a326041584b88c534663bb829102.1450401186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

This adds SATA device node to r8a7795.dtsi.

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
[uli: adjusted for new MSTP clock scheme]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e14251164480..9ce6a5ea6629 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -767,5 +767,13 @@
 				};
 			};
 		};
+
+		sata: sata@ee300000 {
+			compatible = "renesas,sata-r8a7795";
+			reg = <0 0xee300000 0 0x1fff>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4

