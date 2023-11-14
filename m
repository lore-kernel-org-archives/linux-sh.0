Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66804C07533
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjKNIBU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjKNIBT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:01:19 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15BDF19B
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:01:16 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 843381C0515;
        Tue, 14 Nov 2023 17:01:15 +0900 (JST)
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
Subject: [PATCH v4 30/37] sh: add RTS7751R2D Plus DTS
Date:   Tue, 14 Nov 2023 17:00:21 +0900
Message-Id: <6fb41232e2293f2c4fcc027b6f1b0ad72667dda5.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Renesas RTS7751R2D Plus devicetree.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/rts7751r2dplus.dts | 158 ++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts

diff --git a/arch/sh/boot/dts/rts7751r2dplus.dts b/arch/sh/boot/dts/rts7751r2dplus.dts
new file mode 100644
index 000000000000..c835a20beb4c
--- /dev/null
+++ b/arch/sh/boot/dts/rts7751r2dplus.dts
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Renesas RTS7751R2D Plus
+ */
+
+/dts-v1/;
+
+#include "sh7751r.dtsi"
+#include <dt-bindings/display/sm501.h>
+
+/ {
+	model = "Renesas RTS7715R2D Plus";
+	compatible = "renesas,rts7751r2d", "renesas,sh7751r";
+
+	aliases {
+		serial0 = &scif1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
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
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+		renesas,width = <16>;
+		renesas,enable-bit = <0 11>,		/* PCI INTD */
+				     <1 9>,		/* CF IDE */
+				     <2 8>,		/* CF CD */
+				     <3 12>,		/* PCI INTC */
+				     <4 10>,		/* SM501 */
+				     <5 6>,		/* KEY */
+				     <6 5>,		/* RTC ALARM */
+				     <7 4>,		/* RTC T */
+				     <8 7>,		/* SDCARD */
+				     <9 14>,		/* PCI INTA */
+				     <10 13>,		/* PCI INTB */
+				     <11 0>,		/* EXT */
+				     <12 15>;		/* TP */
+	};
+
+	display@0 {
+		compatible = "smi,sm501";
+		reg = <0x10000000 0x03e00000
+		       0x13e00000 0x00200000>;
+		interrupt-parent = <&r2dintc>;
+		interrupts = <4>;
+		mode = "640x480-16@60";
+		little-endian;
+		smi,devices = <(SM501_USE_USB_HOST | SM501_USE_UART0)>;
+		interrupt-name = "sm501";
+		swap-fb-endian;
+
+		crt {
+			smi,flags = <(SM501FB_FLAG_USE_INIT_MODE |
+				      SM501FB_FLAG_DISABLE_AT_EXIT |
+				      SM501FB_FLAG_USE_HWCURSOR |
+				      SM501FB_FLAG_USE_HWACCEL)>;
+		};
+
+		panel {
+			bpp = <16>;
+			edid = [00 ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00
+				00 00 01 04 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 f0 0a 80 fb 20 e0 25 10 32 60
+				02 00 00 00 00 00 00 06 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bd];
+			smi,flags = <(SM501FB_FLAG_USE_INIT_MODE |
+				      SM501FB_FLAG_DISABLE_AT_EXIT |
+				      SM501FB_FLAG_USE_HWCURSOR |
+				      SM501FB_FLAG_USE_HWACCEL)>;
+		};
+	};
+
+	compact-flash@b4001000 {
+		compatible = "renesas,rts7751r2d-ata", "ata-generic";
+		reg = <0xb4001000 0x0e>, <0xb400080c 2>;
+		reg-shift = <1>;
+		interrupt-parent = <&r2dintc>;
+		interrupts = <1>;
+	};
+
+	flash@0 {
+		compatible = "cfi-flash";
+		reg = <0x00000000 0x02000000>;
+		device-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "U-Boot";
+			reg = <0x00000000 0x00040000>;
+		};
+
+		partition@1 {
+			label = "Environemt";
+			reg = <0x00040000 0x00040000>;
+		};
+
+		partition@2 {
+			label = "Kernel";
+			reg = <0x00080000 0x001c0000>;
+		};
+
+		partition@3 {
+			label = "Flash_FS";
+			reg = <0x00240000 0x00dc0000>;
+		};
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
+	interrupt-parent = <&r2dintc>;
+	renesas,bcr1 = <0x40080000>;
+	renesas,intm = <0x0000c3ff>;
+	renesas,aintm = <0x0000380f>;
+	renesas,config = <1 0xfb900047>, <4 0xab000001>;
+	renesas,mcrmask = <0x40000004>;
+
+	interrupt-map = <0x0000 0 0 1 &r2dintc 9>,
+			<0x0000 0 0 2 &r2dintc 10>,
+			<0x0000 0 0 3 &r2dintc 3>,
+			<0x0000 0 0 4 &r2dintc 0>,
+			<0x0800 0 0 1 &r2dintc 10>,
+			<0x0800 0 0 2 &r2dintc 3>,
+			<0x0800 0 0 3 &r2dintc 0>,
+			<0x0800 0 0 4 &r2dintc 9>,
+			<0x1000 0 0 1 &r2dintc 3>,
+			<0x1000 0 0 2 &r2dintc 0>,
+			<0x1000 0 0 3 &r2dintc 9>,
+			<0x1000 0 0 4 &r2dintc 10>;
+			interrupt-map-mask = <0x1800 0 0 7>;
+	status = "okay";
+};
-- 
2.39.2

