Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DA0C6FD1C
	for <linux-sh@archiver.kernel.org>; Thu, 23 Mar 2023 10:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCWKXK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjCWKXI (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 23 Mar 2023 06:23:08 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568BB30F3
        for <linux-sh@vger.kernel.org>; Thu, 23 Mar 2023 03:23:06 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by baptiste.telenet-ops.be with bizsmtp
        id bmP32900n1C8whw01mP4V1; Thu, 23 Mar 2023 11:23:04 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pfI5N-00EKrY-K1;
        Thu, 23 Mar 2023 11:23:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pfI63-00CE9y-RH;
        Thu, 23 Mar 2023 11:23:03 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] sh: Replace <uapi/asm/types.h> by <asm-generic/int-ll64.h>
Date:   Thu, 23 Mar 2023 11:22:59 +0100
Message-Id: <26932016c83c2ad350db59f5daf96117a38bbbd8.1679566927.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

As arch/sh/include/uapi/asm/types.h doesn't exist, sh doesn't provide
any sh-specific uapi definitions, and it can just include
<asm-generic/int-ll64.h>, like most other architectures.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Rebased for SPDX-License-Identifier addition in 2017.

 arch/sh/include/asm/types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
index 68eb24ad201383ef..9b3fc923ee28701c 100644
--- a/arch/sh/include/asm/types.h
+++ b/arch/sh/include/asm/types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SH_TYPES_H
 #define __ASM_SH_TYPES_H
 
-#include <uapi/asm/types.h>
+#include <asm-generic/int-ll64.h>
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
-- 
2.34.1

