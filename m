Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B6C4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjKNIBU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjKNIBT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:01:19 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F8C3195
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:01:16 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 7469E1C0509;
        Tue, 14 Nov 2023 17:01:16 +0900 (JST)
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
Subject: [PATCH v4 31/37] sh: Add IO DATA LANDISK dts
Date:   Tue, 14 Nov 2023 17:00:22 +0900
Message-Id: <3cfcf423eec19ce0b349093dd54b8a9959ed80eb.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

IO DATA DEVICE Inc. LANDISK HDL-U devicetree.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/landisk.dts | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 arch/sh/boot/dts/landisk.dts

diff --git a/arch/sh/boot/dts/landisk.dts b/arch/sh/boot/dts/landisk.dts
new file mode 100644
index 000000000000..2985cba0202a
--- /dev/null
+++ b/arch/sh/boot/dts/landisk.dts
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the IO DATA DEVICE LANDISK
+ */
+
+/dts-v1/;
+
+#include "sh7751r.dtsi"
+
+/ {
+	model = "IO DATA Device LANDISK";
+	compatible = "iodata,landisk", "renesas,sh7751r";
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

