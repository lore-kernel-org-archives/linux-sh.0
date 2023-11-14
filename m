Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3C4C4167D
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKNIA5 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjKNIA4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:56 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F28119B
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:53 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id B868C1C00A4;
        Tue, 14 Nov 2023 17:00:52 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v4 11/37] sh: Add old PCI drivers compatible stub.
Date:   Tue, 14 Nov 2023 17:00:02 +0900
Message-Id: <5f625f7535f51eb934a3a69318137884aca96304.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Place the stub so that the old driver can reference the moved header file.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/drivers/pci/pci-sh4.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/sh/drivers/pci/pci-sh4.h

diff --git a/arch/sh/drivers/pci/pci-sh4.h b/arch/sh/drivers/pci/pci-sh4.h
new file mode 100644
index 000000000000..c051a1ffb082
--- /dev/null
+++ b/arch/sh/drivers/pci/pci-sh4.h
@@ -0,0 +1 @@
+#include <asm/pci-sh4.h>
-- 
2.39.2

