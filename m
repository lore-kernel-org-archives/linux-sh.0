Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7FBCA552A
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjIMJYS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbjIMJYM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:12 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E370419AA
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 23837d95-2882-4d88-9cc7-d488e0cd0ca2;
        Wed, 13 Sep 2023 18:24:06 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 2770C1C00A0;
        Wed, 13 Sep 2023 18:24:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v2 21/30] Documentation/devicetree: sm501fb add properies.
Date:   Wed, 13 Sep 2023 18:23:46 +0900
Message-Id: <e32063a36916d84c88dacfbaaf345418d0028d18.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

SM501's OF support is not enough parameter in platform device.
This change adds the missing parameter.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 Documentation/devicetree/bindings/display/sm501fb.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sm501fb.txt b/Documentation/devicetree/bindings/display/sm501fb.txt
index 1c79c267a57f..4c4920394431 100644
--- a/Documentation/devicetree/bindings/display/sm501fb.txt
+++ b/Documentation/devicetree/bindings/display/sm501fb.txt
@@ -20,6 +20,17 @@ Optional properties:
   set different foreign endian.
 - big-endian: available on little endian systems, to
   set different foreign endian.
+- sm501,devices: select peripheral functions.
+  available usb-host, usb-gadget, ssp0, ssp,1 uart0, uart1, accel,
+            ac97, i2s, gpio and all.
+- sm501,mclk: SM501 mclk frequency.
+- sm501,m1xclk: SM501 m1xclk frequency.
+- sm501,misc-timing: SM501 Miscellaneous Timing reg value.
+- sm501,misc-control: SM501 Miscellaneous Control reg value.
+- sm501,gpio-low: SM501 GPIO31-0 Control reg value.
+- sm501,gpio-high: SM501 GPIO63-32 Control reg value.
+- sm501,num-i2c: I2C channel number.
+- sm501,gpio-i2c: I2C assigned GPIO.
 
 Example for MPC5200:
 	display@1,0 {
-- 
2.39.2

