From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 01 Aug 2018 18:53:31 +0000
Subject: [PATCH v2] sh: prefer _THIS_IP_ to current_text_addr
Message-Id: <20180801185331.39535-1-ndesaulniers@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>

As part of the effort to reduce the code duplication between _THIS_IP_
and current_text_addr(), let's consolidate callers of
current_text_addr() to use _THIS_IP_.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sh/include/asm/kexec.h | 3 ++-
 arch/sh/kernel/dwarf.c      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/kexec.h b/arch/sh/include/asm/kexec.h
index fd5f331a3912..927d80ba2332 100644
--- a/arch/sh/include/asm/kexec.h
+++ b/arch/sh/include/asm/kexec.h
@@ -4,6 +4,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/string.h>
+#include <linux/kernel.h>
 
 /*
  * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
@@ -61,7 +62,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 		__asm__ __volatile__ ("stc gbr, %0" : "=r" (newregs->gbr));
 		__asm__ __volatile__ ("stc sr, %0" : "=r" (newregs->sr));
 
-		newregs->pc = (unsigned long)current_text_addr();
+		newregs->pc = _THIS_IP_;
 	}
 }
 #else
diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index 1a2526676a87..bb511e2d9d68 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -599,7 +599,7 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 	 * time this function makes its first function call.
 	 */
 	if (!pc || !prev)
-		pc = (unsigned long)current_text_addr();
+		pc = _THIS_IP_;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/*
-- 
2.18.0.597.ga71716f1ad-goog

