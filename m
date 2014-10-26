From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 17:40:12 +0000
Subject: [PATCH v3 5/9] ARM: shmobile: r8a7791: Add MMCIF0 DT node
Message-Id: <1414345216-14486-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the MMCIF0 device to the r8a7791 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 74f18d89a35f..d20e84aac7f6 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -400,6 +400,15 @@
 		#gpio-range-cells = <3>;
 	};
 
+	mmcif0: mmc@ee200000 {
+		compatible = "renesas,mmcif-r8a7791", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_MMCIF0>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
 	sdhi0: sd@ee100000 {
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee100000 0 0x200>;
-- 
2.0.4

