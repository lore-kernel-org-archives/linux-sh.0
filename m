Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC65CA5529
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbjIMJYS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbjIMJYM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7619A9
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 5b92773b-5295-4242-bef2-c0ebdded0e5e;
        Wed, 13 Sep 2023 18:24:07 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 58B391C0198;
        Wed, 13 Sep 2023 18:24:07 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 26/30] arch/sh: RTS7751R2D Plus DeviceTree.
Date:   Wed, 13 Sep 2023 18:23:51 +0900
Message-Id: <d63793503fbbc7d5ca7b40d6b31678d371b69c29.1694596125.git.ysato@users.sourceforge.jp>
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
 arch/sh/boot/dts/rts7751r2dplus.dts | 124 ++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts

diff --git a/arch/sh/boot/dts/rts7751r2dplus.dts b/arch/sh/boot/dts/rts7751r2dplus.dts
new file mode 100644
index 000000000000..a08061133841
--- /dev/null
+++ b/arch/sh/boot/dts/rts7751r2dplus.dts
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Renesas RTS7751R2D Plus
+ */
+
+/dts-v1/;
+
+#include "sh7751.dtsi"
+
+/ {
+	model = "Renesas RTS7715R2D Plus";
+	compatible = "renesas,r2dplus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+
+	aliases {
+		serial0 = &scif1;
+	};
+
+	chosen {
+	};
+
+	clocks {
+		xtal: oscillator {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <22222222>;
+		};
+
+		cpg: cpg@ffc00000 {
+			compatible = "renesas,sh7750r-cpg",
+				     "renesas,sh7750-cpg";
+			renesas,mode = <5>;
+		};
+	};
+
+	cpus {
+		cpu@0 {
+		      clock-frequency = <266666666>;
+		};
+	};
+
+	memory@c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+
+	r2dintc: sh7751irl_encoder@a4000000 {
+		compatible = "renesas,sh7751-irl-ext";
+		reg = <0xa4000000 0x02>;
+		interrupt-controller;
+		#address-cells = <1>;
+		#interrupt-cells = <2>;
+		sh7751irl,width = <16>;
+		sh7751irl,polarity = <0>;
+		sh7751irl,irqbit =<11>,		/* PCI INTD */
+				  <9>,		/* CF IDE */
+				  <8>,		/* CF CD */
+				  <12>,		/* PCI INTC */
+				  <10>,		/* SM501 */
+				  <6>,		/* KEY */
+				  <5>,		/* RTC ALARM */
+				  <4>,		/* RTC T */
+				  <7>,		/* SDCARD */
+				  <14>,		/* PCI INTA */
+				  <13>,		/* PCI INTB */
+				  <0>,		/* EXT */
+				  <15>;		/* TP */
+	};
+
+	display@1,0 {
+		compatible = "smi,sm501";
+		reg = <0x10000000 0x03e00000
+		       0x13e00000 0x00200000>;
+		interrupt-parent = <&r2dintc>;
+		interrupts = <4 0>;
+		mode = "640x480-16@60";
+		little-endian;
+		sm501,devices = "usb-host","uart0";
+	};
+
+	compact-flash@b4001000 {
+		compatible = "ata-generic";
+		reg = <0xb4001000 0x0e>, <0xb400080c 2>;
+		reg-shift = <1>;
+		interrupt-parent = <&r2dintc>;
+		interrupts = <1 0>;
+	};
+
+	flash@0 {
+		compatible = "cfi-flash";
+		reg = <0x00000000 0x02000000>;
+		device-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		partition@0 {
+			label = "U-Boot";
+			reg = <0x00000000 0x00040000>;
+		};
+		partition@1 {
+			label = "Environemt";
+			reg = <0x00040000 0x00040000>;
+		};
+		partition@2 {
+			label = "Kernel";
+			reg = <0x00080000 0x001c0000>;
+		};
+		partition@3 {
+			label = "Flash_FS";
+			reg = <0x00240000 0x00dc0000>;
+		};
+	};
+
+	pci@fe200000 {
+		compatible = "renesas,r2d-pci", "renesas,sh7751-pci";
+		#interrupt-cells = <1>;
+		interrupt-parent = <&r2dintc>;
+		eth@2,0 {
+			reg = <0x1000 0 0 0 0>;
+			interrupts = <3 0>;
+		};
+	};
+};
-- 
2.39.2

