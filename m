Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6107BCDB48E
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjJNOyg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjJNOy1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:27 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965DCD7
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:26 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 87092f59-b890-4ffa-b4bd-d36d4be5688c;
        Sat, 14 Oct 2023 23:54:25 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id D3BAE1C0037;
        Sat, 14 Oct 2023 23:54:24 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH v3 32/35] arch/sh/boot/dts: USL-5P DeviceTree.
Date:   Sat, 14 Oct 2023 23:54:07 +0900
Message-Id: <ad6a5ba411562c480aa2dbec430377a7e4022434.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

IO DATA Device USL-5P devicetree.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/usl-5p.dts | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 arch/sh/boot/dts/usl-5p.dts

diff --git a/arch/sh/boot/dts/usl-5p.dts b/arch/sh/boot/dts/usl-5p.dts
new file mode 100644
index 000000000000..ce5320348140
--- /dev/null
+++ b/arch/sh/boot/dts/usl-5p.dts
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the IO DATA DEVICE USL-5P
+ */
+
+/dts-v1/;
+
+#include "sh7751r.dtsi"
+
+/ {
+	model = "IO-DATA Device USL-5P";
+	compatible = "iodata,usl-5p", "renesas,sh7751r";
+
+	aliases {
+		serial0 = &scif1;
+	};
+
+	chosen {
+		stdout-path = "serial0:9600n8";
+	};
+
+	memory@c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+
+	julianintc: sh7751irl_encoder@b0000005 {
+		compatible = "renesas,sh7751-irl-ext";
+		reg = <0xb0000005 0x01>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		renesas,width = <8>;
+		renesas,regtype = "enable";
+		renesas,irqbit = <0xffffffff>,	/* Not use */
+				 <0xffffffff>,
+				 <0xffffffff>,
+				 <0xffffffff>,
+				 <0xffffffff>,
+				 <0>,		/* PCI INTA */
+				 <1>,		/* PCI INTB */
+				 <2>,		/* PCI INTC */
+				 <3>,		/* PCI INTD */
+				 <4>,		/* ATA */
+				 <5>,		/* CF */
+				 <6>,		/* Power Switch */
+				 <7>;		/* Button */
+	};
+
+	oscillator {
+		clock-frequency = <22222222>;
+	};
+
+	compact-flash@b4001000 {
+		compatible = "iodata,usl-5p-ata", "ata-generic";
+		reg = <0xb4000040 0x0e>, <0xb400002c 2>;
+		reg-shift = <1>;
+		interrupt-parent = <&julianintc>;
+		interrupts = <10>;
+	};
+
+	soc {
+		clock-controller@ffc00000 {
+			renesas,mode = <5>;
+		};
+
+		pci@fe200000 {
+			compatible = "renesas,pci-sh7751";
+			renesas,bcr1 = <0x00080000>;
+			renesas,config = <6 0xd0000000>;
+			renesas,mcrmask = <0x40000004>;
+			interrupt-map = <0x0000 0 0 1 &julianintc 5>,
+					<0x0000 0 0 2 &julianintc 6>,
+					<0x0000 0 0 3 &julianintc 7>,
+					<0x0000 0 0 4 &julianintc 8>,
+					<0x0800 0 0 1 &julianintc 6>,
+					<0x0800 0 0 2 &julianintc 7>,
+					<0x0800 0 0 3 &julianintc 8>,
+					<0x0800 0 0 4 &julianintc 5>,
+					<0x1000 0 0 1 &julianintc 7>,
+					<0x1000 0 0 2 &julianintc 8>,
+					<0x1000 0 0 3 &julianintc 5>,
+					<0x1000 0 0 4 &julianintc 6>;
+			interrupt-map-mask = <0x1800 0 0 7>;
+		};
+	};
+};
-- 
2.39.2

