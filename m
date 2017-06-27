From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Jun 2017 19:20:50 +0000
Subject: [PATCH] sh: mark end of BUG() implementation as unreachable
Message-Id: <20170627192050.GA66784@beast>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-sh@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>, linux-kernel@vger.kernel.org

When building the sh architecture, the compiler doesn't realize that
BUG() doesn't return, so it will complain about functions using BUG()
that are marked with the noreturn attribute:

   lib/string.c: In function 'fortify_panic':
>> lib/string.c:986:1: warning: 'noreturn' function does return
    }
    ^

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sh/include/asm/bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index 1b77f068be2b..c9828f785ca0 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -48,6 +48,7 @@ do {							\
 		   "i" (__FILE__),			\
 		   "i" (__LINE__), "i" (0),		\
 		   "i" (sizeof(struct bug_entry)));	\
+	unreachable();					\
 } while (0)
 
 #define __WARN_FLAGS(flags)				\
-- 
2.7.4


-- 
Kees Cook
Pixel Security
