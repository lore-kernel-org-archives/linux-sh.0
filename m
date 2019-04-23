From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 23 Apr 2019 20:29:05 +0000
Subject: [PATCH] sh: require --Wl,--hash-style=sysv
Message-Id: <20190423202907.234180-1-ndesaulniers@google.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: Nick Desaulniers <ndesaulniers@google.com>, Andy Lutomirsky <luto@kernel.org>, clang-built-linux@googlegroups.com, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Towards the goal of removing cc-ldoption, prefer ld-option, or better
yet, require --Wl,--hash-style=sysv since the selftest for vdso's
requires DT_HASH.

Cc: Andy Lutomirsky <luto@kernel.org>
Cc: clang-built-linux@googlegroups.com
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sh/kernel/vsyscall/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
index 5db6579bc44c..6e8664448048 100644
--- a/arch/sh/kernel/vsyscall/Makefile
+++ b/arch/sh/kernel/vsyscall/Makefile
@@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
 
 export CPPFLAGS_vsyscall.lds += -P -C -Ush
 
-vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
 
 SYSCFLAGS_vsyscall-trapa.so	= $(vsyscall-flags)
 
-- 
2.21.0.593.g511ec345e18-goog
