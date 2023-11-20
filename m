Return-Path: <linux-sh+bounces-1-linux-sh=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA1EC197A0
	for <linux-sh@archiver.kernel.org>; Mon, 20 Nov 2023 23:54:54 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA3D1F25089
	for <linux-sh@archiver.kernel.org>; Mon, 20 Nov 2023 23:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC93B2B7;
	Mon, 20 Nov 2023 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXz+XwPx"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1AECD;
	Mon, 20 Nov 2023 15:54:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E136C433C7;
	Mon, 20 Nov 2023 23:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524488;
	bh=IkpIZj++DJgUNFvrpRT/go6WOMEZiOgtvEqU2kpcy+o=;
	h=From:To:Cc:Subject:Date:From;
	b=DXz+XwPxEaFg7E7aF4yQHNjaOd0eD2gksxKsFF5RcAx6Piy6+mqkPE/LFE6Y+w08D
	 cKVqaeX3XHn0x6zx72LzYWnSwZYz1pG6/BSUTzdl9vZZfTHT9kzL2hTMYVIzgsLgb4
	 3ZB2TnJOTaJkS50yuU2XazXA26XROj9RYl9aE1DDviJG6ilLzaxd1PDVRSwtpN4ce8
	 lW6lOGVC7Fu2j/tBgfXexhrRCL47I7SZW4td35vY9QOVkYemQxl09jYzKWk1RnvOY/
	 usQhTteBKJ/GyUHq0XDgSUsTha+EuXM2f/RMYCkm7b7GXqBQQngOUxtCDJKDf2vrSl
	 34jcPPxiWQUkg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: remove unneeded $(foreach )
Date: Tue, 21 Nov 2023 08:54:23 +0900
Message-Id: <20231120235423.4103310-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to use $(foreach ...) for iterating over just one
parameter.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/kernel/vsyscall/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
index 6e8664448048..118744d349e2 100644
--- a/arch/sh/kernel/vsyscall/Makefile
+++ b/arch/sh/kernel/vsyscall/Makefile
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += vsyscall.o vsyscall-syscall.o vsyscall-syms.o
 
-$(obj)/vsyscall-syscall.o: \
-	$(foreach F,trapa,$(obj)/vsyscall-$F.so)
+$(obj)/vsyscall-syscall.o: $(obj)/vsyscall-trapa.so
 
 # Teach kbuild about targets
-targets += $(foreach F,trapa,vsyscall-$F.o vsyscall-$F.so)
+targets += vsyscall-trapa.o vsyscall-traps.so
 targets += vsyscall-note.o vsyscall.lds vsyscall-dummy.o
 
 # The DSO images are built using a special linker script
-- 
2.40.1


