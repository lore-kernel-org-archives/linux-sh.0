Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA68CDB488
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjJNOye (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjJNOy0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:26 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9976EC9
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:25 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 52e33cb5-ae87-48dc-907f-4b27f36b1e89;
        Sat, 14 Oct 2023 23:54:24 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 7F3021C04FD;
        Sat, 14 Oct 2023 23:54:23 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, dlemoal@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH v3 28/35] Documentation/devicetree/bindings/ata: ata-generic.yaml add usl-5p and rts7751r2d.
Date:   Sat, 14 Oct 2023 23:54:03 +0900
Message-Id: <0af21a9c4bf257c09254077c349bbb67530cb35c.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

usl-5p and rts7751r2d using ata-generic driver.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 Documentation/devicetree/bindings/ata/ata-generic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ata-generic.yaml b/Documentation/devicetree/bindings/ata/ata-generic.yaml
index 0697927f3d7e..1025b3b351d0 100644
--- a/Documentation/devicetree/bindings/ata/ata-generic.yaml
+++ b/Documentation/devicetree/bindings/ata/ata-generic.yaml
@@ -18,6 +18,8 @@ properties:
       - enum:
           - arm,vexpress-cf
           - fsl,mpc8349emitx-pata
+          - iodata,usl-5p-ata
+          - renesas,rts7751r2d-ata
       - const: ata-generic
 
   reg:
-- 
2.39.2

