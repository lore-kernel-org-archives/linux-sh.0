Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A865C4167B
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjKNIBW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjKNIBV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:01:21 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2803195
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:01:17 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 6D0E11C0540;
        Tue, 14 Nov 2023 17:01:17 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 32/37] sh: Add IO DATA USL-5P dts
Date:   Tue, 14 Nov 2023 17:00:23 +0900
Message-Id: <59c11b5e41d94b5b10e12fe5d8179adc0138a666.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

IO DATA DEVICE Inc. USL-5P devicetree.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/usl-5p.dts | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 arch/sh/boot/dts/usl-5p.dts

diff --git a/arch/sh/boot/dts/usl-5p.dts b/arch/sh/boot/dts/usl-5p.dts
new file mode 100644
index 000000000000..fba37472ebae
--- /dev/null
+++ b/arch/sh/boot/dts/usl-5p.dts
@@ -0,0 +1,84 @@
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
+		renesas,enable-bit = <5 0>,	/* PCI INTA */
+				     <6 1>,	/* PCI INTB */
+				     <7 2>,	/* PCI INTC */
+				     <8 3>,	/* PCI INTD */
+				     <9 4>,	/* ATA */
+				     <10 5>,	/* CF */
+				     <11 6>,	/* Power Switch */
+				     <12 7>;	/* Button */
+	};
+
+	compact-flash@b4000040 {
+		compatible = "iodata,usl-5p-ata", "ata-generic";
+		reg = <0xb4000040 0x0e>, <0xb400002c 2>;
+		reg-shift = <1>;
+		interrupt-parent = <&julianintc>;
+		interrupts = <10>;
+	};
+};
+
+&xtal {
+	clock-frequency = <22222222>;
+};
+
+&cpg {
+	renesas,mode = <5>;
+};
+
+&scif1 {
+	status = "okay";
+};
+
+&pcic {
+	renesas,bcr1 = <0x00080000>;
+	renesas,config = <6 0xd0000000>;
+	renesas,mcrmask = <0x40000004>;
+	interrupt-map = <0x0000 0 0 1 &julianintc 5>,
+			<0x0000 0 0 2 &julianintc 6>,
+			<0x0000 0 0 3 &julianintc 7>,
+			<0x0000 0 0 4 &julianintc 8>,
+			<0x0800 0 0 1 &julianintc 6>,
+			<0x0800 0 0 2 &julianintc 7>,
+			<0x0800 0 0 3 &julianintc 8>,
+			<0x0800 0 0 4 &julianintc 5>,
+			<0x1000 0 0 1 &julianintc 7>,
+			<0x1000 0 0 2 &julianintc 8>,
+			<0x1000 0 0 3 &julianintc 5>,
+			<0x1000 0 0 4 &julianintc 6>;
+			interrupt-map-mask = <0x1800 0 0 7>;
+	status = "okay";
+};
-- 
2.39.2

