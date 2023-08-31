Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E708C83F1F
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 01:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344986AbjHaBMQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 21:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbjHaBMO (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 21:12:14 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7222ECE4
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 18:12:08 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id f1f37368-b028-419d-9883-ec77e2a92013;
        Thu, 31 Aug 2023 10:12:07 +0900 (JST)
Received: from SIOS1075.flets-east.jp (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 0438D1C0015;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RESEND RFC PATCH 11/12] sh: target dts.
Date:   Thu, 31 Aug 2023 10:11:58 +0900
Message-Id: <1a7d32f58935aee952750a088702f7f2798972d8.1693444193.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693444193.git.ysato@users.sourceforge.jp>
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

- rts7751r2dplus - Renesas RTS7751R2D-PLUS board.
- landisk - IO DATA DEVICE LANDISK
- usl-5p - IO DATA DECVICE USL-5P

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/include/dt-bindings |   1 +
 arch/sh/boot/dts/landisk.dts         | 142 ++++++++++++++++++++++
 arch/sh/boot/dts/rts7751r2dplus.dts  | 168 +++++++++++++++++++++++++++
 arch/sh/boot/dts/usl-5p.dts          | 146 +++++++++++++++++++++++
 4 files changed, 457 insertions(+)
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts
 create mode 100644 arch/sh/boot/dts/usl-5p.dts

diff --git a/arch/sh/boot/dts/include/dt-bindings b/arch/sh/boot/dts/include/dt-bindings
new file mode 120000
index 000000000000..08c00e4972fa
--- /dev/null
+++ b/arch/sh/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/sh/boot/dts/landisk.dts b/arch/sh/boot/dts/landisk.dts
new file mode 100644
index 000000000000..0d0a5e44a2d7
--- /dev/null
+++ b/arch/sh/boot/dts/landisk.dts
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree source for IO DATA DEVICE LANDISK
+ *
+ * Copyright 2023 Yoshinori Sato
+ */
+
+#include <dt-bindings/interrupt-controller/sh_intc.h>
+
+/dts-v1/;
+/ {
+	model = "IO-DATA Device LANDISK";
+	compatible = "iodata,landisk";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+	chosen {
+		stdout-path = &sci1;
+	};
+	aliases {
+		serial1 = &sci1;
+	};
+
+	oclk: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <22222222>;
+	};
+	pllclk: pllclk {
+		compatible = "renesas,sh7750-pll-clock";
+		clocks = <&oclk>;
+		#clock-cells = <0>;
+		sh7750,md = <5>;
+		sh7750,rtype = <1>;
+		reg = <0xffc00000 2>, <0xffc00008 4>;
+	};
+	iclk: iclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <6>;
+		clock-output-names = "ick";
+	};
+	bclk: bclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <3>;
+		clock-output-names = "bck";
+	};
+	fclk: fclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <0>;
+		clock-output-names = "fck";
+	};
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+		      compatible = "renesas,sh4", "renesas,sh";
+		      clock-frequency = <266666666>;
+		};
+	};
+	memory@c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+	shintc: interrupt-controller@ffd00000 {
+		compatible = "renesas,sh7751-intc";
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0xffd00000 14>, <0xfe080000 128>;
+	};
+	julianintc: julianintc@a4000000 {
+		compatible = "iodata,julian-intc";
+		reg = <0xb0000000 0x08>;
+		interrupt-controller;
+		#address-cells = <1>;
+		#interrupt-cells = <2>;
+	};
+	sci1: serial@ffe80000 {
+		compatible = "renesas,scif";
+		reg = <0xffe80000 0x100>;
+		interrupts = <evt2irq(0x700) 0
+			      evt2irq(0x720) 0
+			      evt2irq(0x760) 0
+			      evt2irq(0x740) 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+	tmu: timer@ffd80008 {
+		compatible = "renesas,tmu";
+		reg = <0xffd80000 12>;
+		interrupts = <evt2irq(0x400) 0
+			      evt2irq(0x420) 0
+			      evt2irq(0x440) 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+		renesas,channels = <0x03>;
+	};
+
+	pci@fe200000 {
+		compatible = "renesas,sh7751-pci", "iodata,julian";
+		device_type = "pci";
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+			 <0x01000000 0 0xfe240000 0xfe240000 0 0x00040000>;
+		reg = <0xfe200000 0x0400>,
+		      <0x0c000000 0x04000000>,
+		      <0xff800000 0x0030>;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&julianintc>;
+		eth@0,0 {
+			reg = <0x0000 0 0 0 0>;
+			interrupts = <5 0>;
+		};
+		ata@1,0 {
+			reg = <0x0800 0 0 0 0>;
+			interrupts = <6 0>;
+		};
+		usb@2,0 {
+			reg = <0x1000 0 0 0 0>;
+			interrupts = <7 0>;
+		};
+		usb@2,1 {
+			reg = <0x1100 0 0 0 0>;
+			interrupts = <8 0>;
+		};
+		usb@2,2 {
+			reg = <0x1200 0 0 0 0>;
+			interrupts = <5 0>;
+		};
+	};
+};
diff --git a/arch/sh/boot/dts/rts7751r2dplus.dts b/arch/sh/boot/dts/rts7751r2dplus.dts
new file mode 100644
index 000000000000..1d64753f47a2
--- /dev/null
+++ b/arch/sh/boot/dts/rts7751r2dplus.dts
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree source for Renesas RTS7751R2D Plus
+ *
+ * Copyright 2023 Yoshinori Sato
+ */
+
+#include <dt-bindings/interrupt-controller/sh_intc.h>
+
+/dts-v1/;
+/ {
+	model = "Renesas RTS7715R2D Plus";
+	compatible = "renesas,r2dplus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+	chosen {
+		stdout-path = &sci1;
+	};
+	aliases {
+		serial1 = &sci1;
+	};
+
+	oclk: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <22222222>;
+	};
+	pllclk: pllclk {
+		compatible = "renesas,sh7750-pll-clock";
+		clocks = <&oclk>;
+		#clock-cells = <0>;
+		sh7750,md = <5>;
+		sh7750,rtype = <1>;
+		reg = <0xffc00000 2>, <0xffc00008 4>;
+	};
+	iclk: iclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <6>;
+		clock-output-names = "ick";
+	};
+	bclk: bclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <3>;
+		clock-output-names = "bck";
+	};
+	fclk: fclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <0>;
+		clock-output-names = "fck";
+	};
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+		      compatible = "renesas,sh4", "renesas,sh";
+		      clock-frequency = <266666666>;
+		};
+	};
+	memory@c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+	shintc: interrupt-controller@ffd00000 {
+		compatible = "renesas,sh7751-intc";
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0xffd00000 14>, <0xfe080000 128>;
+	};
+	r2dintc: r2dintc@a4000000 {
+		compatible = "renesas,rts7751r2d-intc";
+		reg = <0xa4000000 0x3a>;
+		interrupt-controller;
+		#address-cells = <1>;
+		#interrupt-cells = <2>;
+	};
+	sci1: serial@ffe80000 {
+		compatible = "renesas,scif";
+		reg = <0xffe80000 0x100>;
+		interrupts = <evt2irq(0x700) 0
+			      evt2irq(0x720) 0
+			      evt2irq(0x760) 0
+			      evt2irq(0x740) 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+	tmu: timer@ffd80008 {
+		compatible = "renesas,tmu";
+		reg = <0xffd80000 12>;
+		interrupts = <evt2irq(0x400) 0
+			      evt2irq(0x420) 0
+			      evt2irq(0x440) 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+		renesas,channels = <0x03>;
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
+		sm501,devices = "usb-host,uart0";
+	};
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
+		compatible = "renesas,sh7751-pci", "renesas,r2d";
+		device_type = "pci";
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+			 <0x01000000 0 0xfe240000 0xfe240000 0 0x00040000>;
+		reg = <0xfe200000 0x0400>,
+		      <0x0c000000 0x04000000>,
+		      <0xff800000 0x0030>;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&r2dintc>;
+		eth@2,0 {
+			reg = <0x1000 0 0 0 0>;
+			interrupts = <3 0>;
+		};
+	};
+};
diff --git a/arch/sh/boot/dts/usl-5p.dts b/arch/sh/boot/dts/usl-5p.dts
new file mode 100644
index 000000000000..3e6624c55c0e
--- /dev/null
+++ b/arch/sh/boot/dts/usl-5p.dts
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree source for IO DATA DEVICE USL-5P
+ *
+ * Copyright 2023 Yoshinori Sato
+ */
+
+#include <dt-bindings/interrupt-controller/sh_intc.h>
+
+/dts-v1/;
+/ {
+	model = "IO-DATA Device USL-5P";
+	compatible = "iodata,usl-5p";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+	chosen {
+		stdout-path = &sci1;
+	};
+	aliases {
+		serial1 = &sci1;
+	};
+
+	oclk: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <22222222>;
+	};
+	pllclk: pllclk {
+		compatible = "renesas,sh7750-pll-clock";
+		clocks = <&oclk>;
+		#clock-cells = <0>;
+		sh7750,md = <5>;
+		sh7750,rtype = <1>;
+		reg = <0xffc00000 2>, <0xffc00008 4>;
+	};
+	iclk: iclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <6>;
+		clock-output-names = "ick";
+	};
+	bclk: bclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <3>;
+		clock-output-names = "bck";
+	};
+	fclk: fclk {
+		compatible = "renesas,sh7750-div-clock";
+		clocks = <&pllclk>;
+		#clock-cells = <0>;
+		reg = <0xffc00000 2>;
+		renesas,offset = <0>;
+		clock-output-names = "fck";
+	};
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+		      compatible = "renesas,sh4", "renesas,sh";
+		      clock-frequency = <266666666>;
+		};
+	};
+	memory@c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+	shintc: interrupt-controller@ffd00000 {
+		compatible = "renesas,sh7751-intc";
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0xffd00000 14>, <0xfe080000 128>;
+	};
+	julianintc: julianintc@a4000000 {
+		compatible = "iodata,julian-intc";
+		reg = <0xb0000000 0x08>;
+		interrupt-controller;
+		#address-cells = <1>;
+		#interrupt-cells = <2>;
+	};
+	sci1: serial@ffe80000 {
+		compatible = "renesas,scif";
+		reg = <0xffe80000 0x100>;
+		interrupts = <evt2irq(0x700) 0
+			      evt2irq(0x720) 0
+			      evt2irq(0x760) 0
+			      evt2irq(0x740) 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+	};
+	tmu: timer@ffd80008 {
+		compatible = "renesas,tmu";
+		reg = <0xffd80000 12>;
+		interrupts = <evt2irq(0x400) 0
+			      evt2irq(0x420) 0
+			      evt2irq(0x440) 0>;
+		clocks = <&fclk>;
+		clock-names = "fck";
+		renesas,channels = <0x03>;
+	};
+
+	compact-flash@b4001000 {
+		compatible = "ata-generic";
+		reg = <0xb4000040 0x0e>, <0xb400002c 2>;
+		reg-shift = <1>;
+		interrupt-parent = <&julianintc>;
+		interrupts = <10 0>;
+	};
+
+	pci@fe200000 {
+		compatible = "renesas,sh7751-pci", "iodata,julian";
+		device_type = "pci";
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+			 <0x01000000 0 0xfe240000 0xfe240000 0 0x00040000>;
+		reg = <0xfe200000 0x0400>,
+		      <0x0c000000 0x04000000>,
+		      <0xff800000 0x0030>;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&julianintc>;
+		eth@0,0 {
+			reg = <0x0000 0 0 0 0>;
+			interrupts = <5 0>;
+		};
+		usb@2,0 {
+			reg = <0x1000 0 0 0 0>;
+			interrupts = <7 0>;
+		};
+		usb@2,1 {
+			reg = <0x1100 0 0 0 0>;
+			interrupts = <8 0>;
+		};
+		usb@2,2 {
+			reg = <0x1200 0 0 0 0>;
+			interrupts = <5 0>;
+		};
+	};
+};
-- 
2.39.2

