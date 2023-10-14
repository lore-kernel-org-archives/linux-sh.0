Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC18CCDB48F
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjJNOy3 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJNOyY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:24 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E5AB
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:23 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 65635323-62c3-47d7-a387-15257b5f2675;
        Sat, 14 Oct 2023 23:54:23 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 5BC2D1C03BE;
        Sat, 14 Oct 2023 23:54:21 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, lee@kernel.org, deller@gmx.de,
        tzimmermann@suse.de, sam@ravnborg.org, robh@kernel.org,
        zhangxuezhi1@coolpad.com, u.kleine-koenig@pengutronix.de
Subject: [RFC PATCH v3 21/35] devicetree/binding/display/sm501fb.txt: sm501fb add properies.
Date:   Sat, 14 Oct 2023 23:53:56 +0900
Message-Id: <bd591135be8b947d0ae9adc5cd53a843dd4482a7.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

SM501's OF support is not enough parameter in platform device.
This change adds the missing parameter.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../devicetree/bindings/display/sm501fb.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sm501fb.txt b/Documentation/devicetree/bindings/display/sm501fb.txt
index 1c79c267a57f..916b768cb340 100644
--- a/Documentation/devicetree/bindings/display/sm501fb.txt
+++ b/Documentation/devicetree/bindings/display/sm501fb.txt
@@ -20,6 +20,23 @@ Optional properties:
   set different foreign endian.
 - big-endian: available on little endian systems, to
   set different foreign endian.
+- route: Framebuffer output route
+  "own": CRT=>CRT, Panel=>Panel
+  "crt-panel": Panel=>CRT, Panel=>Panel
+- swap-fb-endian: swap framebuffer byteorder
+- crt: CRT output control
+- panel: Panel output control
+- smi,devices: select peripheral functions.
+  available usb-host, usb-gadget, ssp0, ssp,1 uart0, uart1, accel,
+            ac97, i2s, gpio and all.
+- smi,mclk: SM501 mclk frequency.
+- smi,m1xclk: SM501 m1xclk frequency.
+- smi,misc-timing: SM501 Miscellaneous Timing reg value.
+- smi,misc-control: SM501 Miscellaneous Control reg value.
+- smi,gpio-low: SM501 GPIO31-0 Control reg value.
+- smi,gpio-high: SM501 GPIO63-32 Control reg value.
+- smi,num-i2c: I2C channel number.
+- smi,gpio-i2c: I2C assigned GPIO.
 
 Example for MPC5200:
 	display@1,0 {
-- 
2.39.2

