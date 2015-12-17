From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 07:21:33 +0000
Subject: [PATCH 2/4] ARM64: renesas: r8a7795: Add VSP instances
Message-Id: <1450336895-4279-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The r8a7795 has 9 VSP instances with various capabilities.

Only the VSPD instances are currently enabled as the other 5 instances
cause the following crash when reading the version register.

[    5.284206] Bad mode in Error handler detected, code 0xbf000002 -- SError
[    5.287590] CPU: 0 PID: 518 Comm: mdev Not tainted 4.4.0-rc3+ #162
[    5.290666] Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
[    5.294044] task: ffffffc039a8b700 ti: ffffffc038db4000 task.ti: ffffffc038db4000
[    5.297770] PC is at 0x9dd0
[    5.299160] LR is at 0x0
[    5.300420] pc : [<0000000000009dd0>] lr : [<0000000000000000>] pstate: 00000010
[    5.304101] sp : 00000000ffd94300
[    5.305750] x12: 0000000000000000
[    5.307446] x11: 0000000000000000 x10: 0000000000000000
[    5.310096] x9 : 0000000000000000 x8 : 0000000000000000
[    5.312745] x7 : 0000000000000000 x6 : 0000000000000000
[    5.315395] x5 : 0000000000000000 x4 : 0000000000000000
[    5.318044] x3 : 0000000000000000 x2 : 0000000000000000
[    5.320694] x1 : 0000000000000000 x0 : 0000000000000000

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 114 +++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 9ce6a5ea6629..47f97ffc6c8b 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -775,5 +775,119 @@
 			clocks = <&cpg CPG_MOD 915>;
 			status = "disabled";
 		};
+
+		vspbc: vsp@fe920000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe920000 0 0x8000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 624>;
+
+			renesas,has-lut;
+			renesas,has-sru;
+			renesas,#rpf = <5>;
+			renesas,#wpf = <1>;
+			status = "disabled";
+		};
+
+		vspbd: vsp@fe960000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe960000 0 0x8000>;
+			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 626>;
+
+			renesas,#rpf = <5>;
+			renesas,#wpf = <1>;
+			status = "disabled";
+		};
+
+		vspi0: vsp@fe9a0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9a0000 0 0x8000>;
+			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 631>;
+
+			renesas,has-lut;
+			renesas,has-sru;
+			renesas,#rpf = <1>;
+			renesas,#uds = <3>;
+			renesas,#wpf = <1>;
+			status = "disabled";
+		};
+
+		vspi1: vsp@fe9b0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9b0000 0 0x8000>;
+			interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 630>;
+
+			renesas,has-lut;
+			renesas,has-sru;
+			renesas,#rpf = <1>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <1>;
+			status = "disabled";
+		};
+
+		vspi2: vsp@fe9c0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9c0000 0 0x8000>;
+			interrupts = <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 629>;
+
+			renesas,has-lut;
+			renesas,has-sru;
+			renesas,#rpf = <1>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <1>;
+			status = "disabled";
+		};
+
+		vspd0: vsp@fea20000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea20000 0 0x8000>;
+			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 623>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <5>;
+			renesas,#wpf = <2>;
+		};
+
+		vspd1: vsp@fea28000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea28000 0 0x8000>;
+			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 622>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <5>;
+			renesas,#wpf = <2>;
+		};
+
+		vspd2: vsp@fea30000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea30000 0 0x8000>;
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 621>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <5>;
+			renesas,#wpf = <2>;
+		};
+
+		vspd3: vsp@fea38000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea38000 0 0x8000>;
+			interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 620>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <5>;
+			renesas,#wpf = <2>;
+		};
 	};
 };
-- 
2.4.10

