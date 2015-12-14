From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 14 Dec 2015 15:42:34 +0000
Subject: [PATCH 2/6] arm64: dts: r8a7795: Add SATA controller node
Message-Id: <1450107758-2544-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

This adds SATA device node to r8a7795.dtsi.

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
[uli: adjusted for new MSTP clock scheme]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c018423..7d4707e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -972,5 +972,13 @@
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
2.6.3

