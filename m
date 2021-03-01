Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EA2C433DB
	for <linux-sh@archiver.kernel.org>; Mon,  1 Mar 2021 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE2164DEF
	for <linux-sh@archiver.kernel.org>; Mon,  1 Mar 2021 14:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbhCAOvM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 1 Mar 2021 09:51:12 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:49158 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhCAOvM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 1 Mar 2021 09:51:12 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121EnqMb002389;
        Mon, 1 Mar 2021 23:49:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121EnqMb002389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614610193;
        bh=MLXrc9ylawdak1qYnKwUdAZxhWx4UIUXr/sP+PFqGYc=;
        h=From:To:Cc:Subject:Date:From;
        b=iuOHEwrlWG9HvJ9De6rYIWfWUQN+vR7ry4BucOoJilJaWHf+YkVQfr8ofmqS2M33X
         AeU4bWIdx3xoZ4hd/bTHe/PZdg5ffaW5SKvm26XwzSa/VePKxDeGspUHAV0ScoMWhg
         kuBc8joXpgOhvvhmSkQwf4hA1/DNc2VZkkV/zF4aETCLabyRCVNO9XDFaTByPtj0n/
         XZJ/VHJH3vQkkEC8DEY2DcgtIBz/555o3vDXMY+wsJSEiCzhYFujsbiw5+GAexool9
         53tQau30sLXz9l0Pb174xlybychSAZeu4rUENgObHD/gJLEXK3jc3vTUCtnTBdDt8x
         /I7x3oyLfjb+Q==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 1/2] sh: syscalls: switch to generic syscalltbl.sh
Date:   Mon,  1 Mar 2021 23:49:44 +0900
Message-Id: <20210301144945.358628-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts sh to use scripts/syscalltbl.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/kernel/syscalls/Makefile      |  7 ++----
 arch/sh/kernel/syscalls/syscalltbl.sh | 32 ---------------------------
 2 files changed, 2 insertions(+), 37 deletions(-)
 delete mode 100644 arch/sh/kernel/syscalls/syscalltbl.sh

diff --git a/arch/sh/kernel/syscalls/Makefile b/arch/sh/kernel/syscalls/Makefile
index 285aaba832d9..ad2492cb5568 100644
--- a/arch/sh/kernel/syscalls/Makefile
+++ b/arch/sh/kernel/syscalls/Makefile
@@ -7,7 +7,7 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
@@ -16,10 +16,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_offset_$(basetarget))'
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
-		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'		\
-		   '$(systbl_offset_$(basetarget))'
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
 
 $(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
diff --git a/arch/sh/kernel/syscalls/syscalltbl.sh b/arch/sh/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index 904b8e6e625d..000000000000
--- a/arch/sh/kernel/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-my_abi="$4"
-offset="$5"
-
-emit() {
-	t_nxt="$1"
-	t_nr="$2"
-	t_entry="$3"
-
-	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
-		t_nxt=$((t_nxt+1))
-	done
-	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
-}
-
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	nxt=0
-	if [ -z "$offset" ]; then
-		offset=0
-	fi
-
-	while read nr abi name entry ; do
-		emit $((nxt+offset)) $((nr+offset)) $entry
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
2.27.0

