Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C07CDB486
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjJNOyb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjJNOyZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:25 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18484C9
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:23 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id e7e1f33a-a6a0-48c9-81c1-fe0fffd66319;
        Sat, 14 Oct 2023 23:54:23 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id CF7771C04FD;
        Sat, 14 Oct 2023 23:54:22 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH v3 26/35] arch/sh/boot/dts: SH7751R SoC Internal peripheral definition dtsi.
Date:   Sat, 14 Oct 2023 23:54:01 +0900
Message-Id: <01c234379a48f89df5150fa2b5eae867df08d858.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Renesas SuperH SH7751R common definition.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/sh7751r.dtsi | 148 ++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)
 create mode 100644 arch/sh/boot/dts/sh7751r.dtsi

diff --git a/arch/sh/boot/dts/sh7751r.dtsi b/arch/sh/boot/dts/sh7751r.dtsi
new file mode 100644
index 000000000000..66f71372baad
--- /dev/null
+++ b/arch/sh/boot/dts/sh7751r.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the SH7751R SoC
+ */
+
+#include <dt-bindings/interrupt-controller/sh_intc.h>
+#include <dt-bindings/clock/sh7750.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+		      compatible = "renesas,sh4", "renesas,sh";
+		      device_type = "cpu";
+		      reg = <0>;
+		      clocks = <&cpg SH7750_CPG_ICK>;
+		      clock-names = "ick";
+		      icache-size = <16384>;
+		      icache-line-size = <32>;
+		      dcache-size = <32768>;
+		      dcache-line-size = <32>;
+		};
+	};
+
+	xtal: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		clock-output-names = "xtal";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&shintc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		cpg: clock-controller@ffc00000 {
+			#clock-cells = <1>;
+			#power-domain-cells = <0>;
+			compatible = "renesas,sh7751r-cpg", "renesas,sh7750-cpg";
+			clocks = <&xtal>;
+			clock-names = "xtal";
+			reg = <0xffc00000 20>, <0xfe0a0000 16>;
+			reg-names = "FRQCR", "CLKSTP00";
+		};
+
+		shintc: interrupt-controller@ffd00000 {
+			compatible = "renesas,sh7751-intc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0xffd00000 20>, <0xfe080000 128>;
+			reg-names = "ICR", "INTPRI00";
+			renesas,ipr-map = IPRDEF(0x240, IPRD, IPR_B12),	/* IRL0 */
+					  IPRDEF(0x2a0, IPRD, IPR_B8),	/* IRL1 */
+					  IPRDEF(0x300, IPRD, IPR_B4),	/* IRL2 */
+					  IPRDEF(0x360, IPRD, IPR_B0),	/* IRL3 */
+					  IPRDEF(0x400, IPRA, IPR_B12),	/* TMU0 */
+					  IPRDEF(0x420, IPRA, IPR_B8),	/* TMU1 */
+					  IPRDEF(0x440, IPRA, IPR_B4),	/* TMU2 TNUI */
+					  IPRDEF(0x460, IPRA, IPR_B4),	/* TMU2 TICPI */
+					  IPRDEF(0x480, IPRA, IPR_B0),	/* RTC ATI */
+					  IPRDEF(0x4a0, IPRA, IPR_B0),	/* RTC PRI */
+					  IPRDEF(0x4c0, IPRA, IPR_B0),	/* RTC CUI */
+					  IPRDEF(0x4e0, IPRB, IPR_B4),	/* SCI ERI */
+					  IPRDEF(0x500, IPRB, IPR_B4),	/* SCI RXI */
+					  IPRDEF(0x520, IPRB, IPR_B4),	/* SCI TXI */
+					  IPRDEF(0x540, IPRB, IPR_B4),	/* SCI TEI */
+					  IPRDEF(0x560, IPRB, IPR_B12),	/* WDT */
+					  IPRDEF(0x580, IPRB, IPR_B8),	/* REF RCMI */
+					  IPRDEF(0x5a0, IPRB, IPR_B4),	/* REF ROVI */
+					  IPRDEF(0x600, IPRC, IPR_B0),	/* H-UDI */
+					  IPRDEF(0x620, IPRC, IPR_B12),	/* GPIO */
+					  IPRDEF(0x640, IPRC, IPR_B8),	/* DMAC DMTE0 */
+					  IPRDEF(0x660, IPRC, IPR_B8),	/* DMAC DMTE1 */
+					  IPRDEF(0x680, IPRC, IPR_B8),	/* DMAC DMTE2 */
+					  IPRDEF(0x6a0, IPRC, IPR_B8),	/* DMAC DMTE3 */
+					  IPRDEF(0x6c0, IPRC, IPR_B8),	/* DMAC DMAE */
+					  IPRDEF(0x700, IPRC, IPR_B4),	/* SCIF ERI */
+					  IPRDEF(0x720, IPRC, IPR_B4),	/* SCIF RXI */
+					  IPRDEF(0x740, IPRC, IPR_B4),	/* SCIF BRI */
+					  IPRDEF(0x760, IPRC, IPR_B4),	/* SCIF TXI */
+					  IPRDEF(0x780, IPRC, IPR_B8),	/* DMAC DMTE4 */
+					  IPRDEF(0x7a0, IPRC, IPR_B8),	/* DMAC DMTE5 */
+					  IPRDEF(0x7c0, IPRC, IPR_B8),	/* DMAC DMTE6 */
+					  IPRDEF(0x7e0, IPRC, IPR_B8),	/* DMAC DMTE7 */
+					  IPRDEF(0xa00, INTPRI00, IPR_B0),	/* PCIC PCISERR */
+					  IPRDEF(0xa20, INTPRI00, IPR_B4),	/* PCIC PCIDMA3 */
+					  IPRDEF(0xa40, INTPRI00, IPR_B4),	/* PCIC PCIDMA2 */
+					  IPRDEF(0xa60, INTPRI00, IPR_B4),	/* PCIC PCIDMA1 */
+					  IPRDEF(0xa80, INTPRI00, IPR_B4),	/* PCIC PCIDMA0 */
+					  IPRDEF(0xaa0, INTPRI00, IPR_B4),	/* PCIC PCIPWON */
+					  IPRDEF(0xac0, INTPRI00, IPR_B4),	/* PCIC PCIPWDWN */
+					  IPRDEF(0xae0, INTPRI00, IPR_B4),	/* PCIC PCIERR */
+					  IPRDEF(0xb00, INTPRI00, IPR_B8),	/* TMU3 */
+					  IPRDEF(0xb80, INTPRI00, IPR_B12);	/* TMU4 */
+		};
+
+		/* sci0 is rarely used, so it is not defined here. */
+		scif1: serial@ffe80000 {
+			compatible = "renesas,scif-sh7751", "renesas,scif";
+			reg = <0xffe80000 0x100>;
+			interrupts = <evt2irq(0x700) 0>,
+				     <evt2irq(0x720) 0>,
+				     <evt2irq(0x760) 0>,
+				     <evt2irq(0x740) 0>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
+			clocks = <&cpg SH7750_CPG_SCIF_CLK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+		};
+
+		/* Normally ch0 and ch1 are used, so we will define ch0 to ch2 here. */
+		tmu0: timer@ffd80000 {
+			compatible = "renesas,tmu-sh", "renesas,tmu";
+			reg = <0xffd80000 12>;
+			interrupts = <evt2irq(0x400) 0>,
+				     <evt2irq(0x420) 0>,
+				     <evt2irq(0x440) 0>,
+				     <evt2irq(0x460) 0>;
+			interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";
+			clocks = <&cpg SH7750_CPG_TMU012_CLK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			#renesas,channels = <3>;
+		};
+
+		pcic: pci@fe200000 {
+			compatible = "renesas,pci-sh7751";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			bus-range = <0 0>;
+			ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+				 <0x01000000 0 0x00000000 0xfe240000 0 0x00040000>;
+			reg = <0xfe200000 0x0400>,
+			      <0x0c000000 0x04000000>,
+			      <0xff800000 0x0030>;
+		};
+	};
+};
-- 
2.39.2

