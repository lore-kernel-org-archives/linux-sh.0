From: Richard Weinberger <richard@nod.at>
Date: Wed, 21 Aug 2013 08:19:31 +0000
Subject: [PATCH 7/8] unicore32: Do not use SUBARCH
Message-Id: <1377073172-3662-8-git-send-email-richard@nod.at>
List-Id: <linux-sh.vger.kernel.org>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>

Forces the user to specify CROSS_COMPILE at compile time instead
of automatically selecting more or less randomly a cross compiler

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/unicore32/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/unicore32/Makefile b/arch/unicore32/Makefile
index b6f5c4c..fae00c8 100644
--- a/arch/unicore32/Makefile
+++ b/arch/unicore32/Makefile
@@ -10,11 +10,6 @@
 #
 # Copyright (C) 2002~2010 by Guan Xue-tao
 #
-ifneq ($(SUBARCH),$(ARCH))
-	ifeq ($(CROSS_COMPILE),)
-		CROSS_COMPILE := $(call cc-cross-prefix, unicore32-linux-)
-	endif
-endif
 
 LDFLAGS_vmlinux		:= -p --no-undefined -X
 
-- 
1.8.1.4

