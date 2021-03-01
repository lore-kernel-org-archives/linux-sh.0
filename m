Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E4BC433E0
	for <linux-sh@archiver.kernel.org>; Mon,  1 Mar 2021 14:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0F16146D
	for <linux-sh@archiver.kernel.org>; Mon,  1 Mar 2021 14:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhCAOvf (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 1 Mar 2021 09:51:35 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:49515 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbhCAOvd (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 1 Mar 2021 09:51:33 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121EnqMc002389;
        Mon, 1 Mar 2021 23:49:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121EnqMc002389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614610193;
        bh=4I317O76POzB7XGCUvI4Y+ZGZlizVtgv4vqLUhN5FKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wbjmWJzJRlTMsDrb93Svg2PEqNctpG9fCK+fogCqQliRfvZfXC8umkCLsjljwa2v0
         ZT3c+8UxWSuHovtYyLVesGf5eluxwwx1OA3JDhKf3aked/S8FgXkFu4IyaRDz25LPj
         l7aJmE4rWYNX8Zw9MuSsRzBYALtVNoc/I8Z9m58Q4gXAmvivuqudIjf/zl3Gy/9Wk9
         UwnKy48WnlFLS7v+KO/cU9lm3OdYg5pPLNmX3RoEaVgPxQ5QCuJBBfr8KvRFtZ8kBj
         eyKDZqIZOC9BA8QehB3UPXFZ1jmkamI932xrmBoLBWYHXQ0gjx3UvhBZU1BDXE5d/c
         D+KTF8NSiHrlQ==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rich Felker <dalias@libc.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 2/2] sh: syscalls: switch to generic syscallhdr.sh
Date:   Mon,  1 Mar 2021 23:49:45 +0900
Message-Id: <20210301144945.358628-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301144945.358628-1-masahiroy@kernel.org>
References: <20210301144945.358628-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts sh to use scripts/syscallhdr.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/kernel/syscalls/Makefile      |  7 ++----
 arch/sh/kernel/syscalls/syscallhdr.sh | 36 ---------------------------
 2 files changed, 2 insertions(+), 41 deletions(-)
 delete mode 100644 arch/sh/kernel/syscalls/syscallhdr.sh

diff --git a/arch/sh/kernel/syscalls/Makefile b/arch/sh/kernel/syscalls/Makefile
index ad2492cb5568..6713c65a25e1 100644
--- a/arch/sh/kernel/syscalls/Makefile
+++ b/arch/sh/kernel/syscalls/Makefile
@@ -6,14 +6,11 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
 
 syscall := $(src)/syscall.tbl
-syshdr := $(srctree)/$(src)/syscallhdr.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
-		   '$(syshdr_abis_$(basetarget))'		\
-		   '$(syshdr_pfx_$(basetarget))'		\
-		   '$(syshdr_offset_$(basetarget))'
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
diff --git a/arch/sh/kernel/syscalls/syscallhdr.sh b/arch/sh/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index 4c0519861e97..000000000000
--- a/arch/sh/kernel/syscalls/syscallhdr.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_UAPI_ASM_SH_`basename "$out" | sed \
-	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	printf "#ifndef %s\n" "${fileguard}"
-	printf "#define %s\n" "${fileguard}"
-	printf "\n"
-
-	nxt=0
-	while read nr abi name entry ; do
-		if [ -z "$offset" ]; then
-			printf "#define __NR_%s%s\t%s\n" \
-				"${prefix}" "${name}" "${nr}"
-		else
-			printf "#define __NR_%s%s\t(%s + %s)\n" \
-				"${prefix}" "${name}" "${offset}" "${nr}"
-		fi
-		nxt=$((nr+1))
-	done
-
-	printf "\n"
-	printf "#ifdef __KERNEL__\n"
-	printf "#define __NR_syscalls\t%s\n" "${nxt}"
-	printf "#endif\n"
-	printf "\n"
-	printf "#endif /* %s */\n" "${fileguard}"
-) > "$out"
-- 
2.27.0

