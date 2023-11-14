Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32999C4167B
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjKNIBL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjKNIBK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:01:10 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2593419E
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:01:06 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 3856E1C04D0;
        Tue, 14 Nov 2023 17:01:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v4 23/37] dt-bindings: display: smi,sm501: SMI SM501 binding json-schema
Date:   Tue, 14 Nov 2023 17:00:14 +0900
Message-Id: <c4e31d061754eb49fc24fdc404ba8196053de06b.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Define SM501 functions and modes.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../bindings/display/smi,sm501.yaml           | 138 ++++++++++++++++++
 include/dt-bindings/display/sm501.h           |  25 ++++
 2 files changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/smi,sm501.yaml
 create mode 100644 include/dt-bindings/display/sm501.h

diff --git a/Documentation/devicetree/bindings/display/smi,sm501.yaml b/Documentation/devicetree/bindings/display/smi,sm501.yaml
new file mode 100644
index 000000000000..4861b8e14ce5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/smi,sm501.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/smi,sm501.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Motion SM501 Mobile Multimedia Companion Chip
+
+maintainers:
+  - Yoshinori Sato <ysato@user.sourceforge.jp>
+
+description: |
+  These DT bindings describe the SM501.
+
+properties:
+  compatible:
+    const:
+      smi,sm501
+
+  reg:
+    maxItems: 2
+    description: |
+     First entry: System Configuration register
+     Second entry: IO space (Display Controller register)
+
+  interrupts:
+    description: SM501 interrupt to the cpu should be described here.
+
+  interrupt-name: true
+
+  mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: select a video mode
+
+  edid:
+    description: |
+      verbatim EDID data block describing attached display.
+      Data from the detailed timing descriptor will be used to
+      program the display controller.
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: available on big endian systems, to set different foreign endian.
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: available on little endian systems, to set different foreign endian.
+
+  swap-fb-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: swap framebuffer byteorder.
+
+  route-crt-panel:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Panel output merge to CRT.
+
+  crt:
+    description: CRT output control
+
+  panel:
+    description: Panel output control
+
+  bpp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Color depth
+
+  smi,flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Display control flags.
+
+  smi,devices:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: SM501 device function select.
+
+  smi,mclk:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: mclk frequency.
+
+  smi,m1xclk:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: m1xclk frequency.
+
+  smi,misc-timing:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Miscellaneous Timing reg value.
+
+  smi,misc-control:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Miscellaneous Control reg value.
+
+  smi,gpio-low:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: GPIO0 to 31 Control reg value.
+
+  smi,gpio-high:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: GPIO32 to 63 Control reg value.
+
+  smi,num-i2c:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: I2C channel number.
+
+  smi,gpio-i2c:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 5
+    description: |
+      GPIO I2C bus number
+      1st field - I2C bus number
+      2nd Field - GPIO SDA
+      3rd Field - GPIO SCL
+      4th Field - Timeout
+      5th Field - udelay
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+
+examples:
+  # MPC5200
+  - |
+    display@1,0 {
+        compatible = "smi,sm501";
+        reg = <0x00000000 0x00800000
+               0x03e00000 0x00200000>;
+        interrupts = <1 1 3>;
+        mode = "640x480-32@60";
+        edid = [00 ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00
+                00 00 01 04 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 f0 0a 80 fb 20 e0 25 10 32 60
+                02 00 00 00 00 00 00 06 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bd];
+    };
diff --git a/include/dt-bindings/display/sm501.h b/include/dt-bindings/display/sm501.h
new file mode 100644
index 000000000000..9cf6566c242e
--- /dev/null
+++ b/include/dt-bindings/display/sm501.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* Platform data definitions */
+
+#define SM501FB_FLAG_USE_INIT_MODE	(1<<0)
+#define SM501FB_FLAG_DISABLE_AT_EXIT	(1<<1)
+#define SM501FB_FLAG_USE_HWCURSOR	(1<<2)
+#define SM501FB_FLAG_USE_HWACCEL	(1<<3)
+#define SM501FB_FLAG_PANEL_NO_FPEN	(1<<4)
+#define SM501FB_FLAG_PANEL_NO_VBIASEN	(1<<5)
+#define SM501FB_FLAG_PANEL_INV_FPEN	(1<<6)
+#define SM501FB_FLAG_PANEL_INV_VBIASEN	(1<<7)
+
+#define SM501_USE_USB_HOST	(1<<0)
+#define SM501_USE_USB_SLAVE	(1<<1)
+#define SM501_USE_SSP0		(1<<2)
+#define SM501_USE_SSP1		(1<<3)
+#define SM501_USE_UART0		(1<<4)
+#define SM501_USE_UART1		(1<<5)
+#define SM501_USE_FBACCEL	(1<<6)
+#define SM501_USE_AC97		(1<<7)
+#define SM501_USE_I2S		(1<<8)
+#define SM501_USE_GPIO		(1<<9)
+
+#define SM501_USE_ALL		(0xffffffff)
-- 
2.39.2

