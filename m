Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD8DCDB485
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjJNOyX (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjJNOyW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:22 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7FE6
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:21 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 263e3cb8-ffbe-47f0-9dfb-7927ec6d7e8f;
        Sat, 14 Oct 2023 23:54:21 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id B3CB11C03BE;
        Sat, 14 Oct 2023 23:54:20 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v3 19/35] Documentation/devicetree/bindings/serial: renesas,scif.yaml Add SH.
Date:   Sat, 14 Oct 2023 23:53:54 +0900
Message-Id: <4596e6d37f626672986ef67e9e7e328db9077b71.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 99030fc18c45..0c938f1fb77b 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -81,6 +81,11 @@ properties:
               - renesas,scif-r9a07g054      # RZ/V2L
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
+      - items:
+          - enum:
+              - renesas,scif-sh7751   # SH7751
+          - const: renesas,scif       # generic SCIF compatible UART
+
   reg:
     maxItems: 1
 
-- 
2.39.2

