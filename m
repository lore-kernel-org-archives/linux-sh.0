Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F46CA552C
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjIMJYT (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbjIMJYM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798181999
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:08 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 7a738ce6-2f27-4bc1-a584-121652bfcbe9;
        Wed, 13 Sep 2023 18:24:08 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id C66901C005D;
        Wed, 13 Sep 2023 18:24:07 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 28/30] arch/sh: USL-5P DeviceTree.
Date:   Wed, 13 Sep 2023 18:23:53 +0900
Message-Id: <65985aa3682d4ddc8bc14044ba2e0ccb7360949c.1694596125.git.ysato@users.sourceforge.jp>
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
 arch/sh/boot/dts/usl-5p.dts | 106 ++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 arch/sh/boot/dts/usl-5p.dts

diff --git a/arch/sh/boot/dts/usl-5p.dts b/arch/sh/boot/dts/usl-5p.dts
new file mode 100644
index 000000000000..574e26cc6191
--- /dev/null
+++ b/arch/sh/boot/dts/usl-5p.dts
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the IO DATA DEVICE USL-5P
+ */
+
+/dts-v1/;
+
+#include "sh7751.dtsi"
+
+/ {
+	model = "IO-DATA Device USL-5P";
+	compatible = "iodata,usl-5p";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+
+	aliases {
+		serial0 = &scif1;
+	};
+
+	chosen {
+		stdout-path = "serial0:9600n8";
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
+	julianintc: sh7751irl_encoder@a4000000 {
+		compatible ="renesas,sh7751-irl-ext";
+		reg = <0xb0000005 0x01>;
+		interrupt-controller;
+		#address-cells = <1>;
+		#interrupt-cells = <2>;
+		sh7751irl,width = <8>;
+		sh7751irl,polarity = <0>;
+		sh7751irl,irqbit = <0xffffffff>,	/* Not use */
+				   <0xffffffff>,
+				   <0xffffffff>,
+				   <0xffffffff>,
+				   <0xffffffff>,
+				   <0>,		/* PCI INTA */
+				   <1>,		/* PCI INTB */
+				   <2>,		/* PCI INTC */
+				   <3>,		/* PCI INTD */
+				   <4>,		/* ATA */
+				   <5>,		/* CF */
+				   <6>,		/* Power Switch */
+				   <7>;		/* Button */
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
+		compatible = "iodata,julian-pci", "renesas,sh7751-pci";
+		#interrupt-cells = <1>;
+		interrupt-parent = <&julianintc>;
+		eth@0,0 {
+			reg = <0x0000 0 0 0 0>;
+			interrupts = <5 0>;
+			interrupt-names = "eth";
+		};
+		usb@2,0 {
+			reg = <0x1000 0 0 0 0>;
+			interrupts = <7 0>;
+			interrupt-names = "ochi";
+		};
+		usb@2,1 {
+			reg = <0x1100 0 0 0 0>;
+			interrupts = <8 0>;
+			interrupt-names = "ohci";
+		};
+		usb@2,2 {
+			reg = <0x1200 0 0 0 0>;
+			interrupts = <5 0>;
+			interrupt-names = "ehci";
+		};
+	};
+};
-- 
2.39.2

