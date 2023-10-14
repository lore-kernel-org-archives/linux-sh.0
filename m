Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A6CDB493
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjJNOyf (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJNOy0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:26 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B64CE
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:25 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id eb1d7895-9ed9-48ae-a298-4d2b871c2bd3;
        Sat, 14 Oct 2023 23:54:25 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 2C2981C03BE;
        Sat, 14 Oct 2023 23:54:25 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RFC PATCH v3 33/35] arch/sh: Add dtbs target support.
Date:   Sat, 14 Oct 2023 23:54:08 +0900
Message-Id: <23b14a38a073e8b5efd80c1931d8be1ea105797a.1697199949.git.ysato@users.sourceforge.jp>
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
 arch/sh/boot/dts/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index 4a6dec9714a9..e6b93360c213 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,2 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_USE_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
+
+dtb-$(CONFIG_CPU_J2) += j2_mimas_v2.dtb
+dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += landisk.dtb
+dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += rts7751r2dplus.dtb
+dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += usl-5p.dtb
-- 
2.39.2

