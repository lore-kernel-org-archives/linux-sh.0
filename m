Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E20CA5525
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbjIMJYP (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527831999
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 51bc4701-a232-4b9e-afa5-1f0e1c9ba23a;
        Wed, 13 Sep 2023 18:24:06 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 8B5FC1C005D;
        Wed, 13 Sep 2023 18:24:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 23/30] arch/sh: Add SH7751 SoC Internal periphreal devicetree.
Date:   Wed, 13 Sep 2023 18:23:48 +0900
Message-Id: <4bf42fc7a928e9a726ea20ee4e2168f993bb34f7.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/sh7751.dtsi | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 arch/sh/boot/dts/sh7751.dtsi

diff --git a/arch/sh/boot/dts/sh7751.dtsi b/arch/sh/boot/dts/sh7751.dtsi
new file mode 100644
index 000000000000..749eab3bce9f
--- /dev/null
+++ b/arch/sh/boot/dts/sh7751.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the SH7751 SoC
+ */
+
+#include <dt-bindings/interrupt-controller/sh_intc.h>
+#include <dt-bindings/clock/sh7750.h>
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+		      compatible = "renesas,sh7751r","renesas,sh4", "renesas,sh";
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		cpg: cpg@ffc00000 {
+			#clock-cells = <1>;
+			compatible = "renesas,sh7750-cpg";
+			clocks = <&xtal>;
+			reg = <0xffc00000 2>, <0xffc00008 4>;
+		};
+
+	};
+
+	shintc: interrupt-controller@ffd00000 {
+		compatible = "renesas,sh7751-intc";
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0xffd00000 14>, <0xfe080000 128>;
+	};
+
+	/* sci0 is rarely used, so it is not defined here. */
+	scif1: serial@ffe80000 {
+		compatible = "renesas,scif";
+		reg = <0xffe80000 0x100>;
+		interrupts = <evt2irq(0x700) 0>,
+			     <evt2irq(0x720) 0>,
+			     <evt2irq(0x760) 0>,
+			     <evt2irq(0x740) 0>;
+		interrupt-names = "eri", "rxi", "bri", "txi";
+		clocks = <&cpg SH7750_CPG_FCK>;
+	};
+
+	/* Normally ch0 and ch1 are used, so we will define ch0 to ch2 here. */
+	tmu0: timer@ffd80008 {
+		compatible = "renesas,tmu";
+		reg = <0xffd80000 12>;
+		interrupts = <evt2irq(0x400) 0>,
+			     <evt2irq(0x420) 0>,
+			     <evt2irq(0x440) 0>,
+			     <evt2irq(0x460) 0>;
+		interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";
+		clocks = <&cpg SH7750_CPG_FCK>;
+		renesas,channels = <3>;
+	};
+
+	pci@fe200000 {
+		compatible = "renesas,sh7751-pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+			 <0x01000000 0 0xfe240000 0xfe240000 0 0x00040000>;
+		reg = <0xfe200000 0x0400>,
+		      <0x0c000000 0x04000000>,
+		      <0xff800000 0x0030>;
+		#interrupt-cells = <1>;
+	};
+};
-- 
2.39.2

