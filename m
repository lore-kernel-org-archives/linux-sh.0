Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BE5CDB484
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjJNOyc (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjJNOy0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:26 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9EEAB
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:24 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 45889b23-c070-4b31-9412-af3c6884de5b;
        Sat, 14 Oct 2023 23:54:24 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id E33CE1C03DF;
        Sat, 14 Oct 2023 23:54:23 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH v3 29/35]  Documentation/devicetree/bindings/soc/renesas/sh.yaml: Add SH7751 based target.
Date:   Sat, 14 Oct 2023 23:54:04 +0900
Message-Id: <35311df6cf65c9f110604cbbdecad2f15ac602b6.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Renesas SuperH based target definition.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../devicetree/bindings/soc/renesas/sh.yaml   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/sh.yaml

diff --git a/Documentation/devicetree/bindings/soc/renesas/sh.yaml b/Documentation/devicetree/bindings/soc/renesas/sh.yaml
new file mode 100644
index 000000000000..3fbff2532ad3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/renesas/sh.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/renesas/sh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SuperH Platform
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: RTS7751R2D Plus
+        items:
+          - enum:
+              - renesas,rts7751r2d # Renesas SH4 2D graphics board
+          - const: renesas,sh7751r
+
+      - description: Julian board
+        items:
+          - enum:
+              - iodata,landisk  # LANDISK HDL-U
+              - iodata,usl-5p   # USL-5P
+          - const: renesas,sh7751r
+
+additionalProperties: true
+
+...
-- 
2.39.2

