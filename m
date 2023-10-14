Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584BACDB48C
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJNOyZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjJNOyX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:23 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F059D8
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:18 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 6b30dd80-3094-420f-87f0-0c41f8d70931;
        Sat, 14 Oct 2023 23:54:17 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 0FF301C0559;
        Sat, 14 Oct 2023 23:54:16 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [RFC PATCH v3 04/35] include/linux/sh_intc.h: Add stub function "intc_finalize".
Date:   Sat, 14 Oct 2023 23:53:39 +0900
Message-Id: <439be55f3920d05e85dbc3e5d503a0287f2b5b88.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This function is not used with OF.
Using a static inline function avoids an external call.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/sh_intc.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index 27ae79191bdc..994b5b05a0d7 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -139,8 +139,13 @@ struct intc_desc symbol __initdata = {					\
 int register_intc_controller(struct intc_desc *desc);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 int intc_irq_lookup(const char *chipname, intc_enum enum_id);
+#ifndef CONFIG_SH_DEVICE_TREE
 void intc_finalize(void);
-
+#else
+static inline void intc_finalize(void)
+{
+}
+#endif
 #ifdef CONFIG_INTC_USERIMASK
 int register_intc_userimask(unsigned long addr);
 #else
-- 
2.39.2

