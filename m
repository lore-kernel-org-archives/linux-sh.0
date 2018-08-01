From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 01 Aug 2018 18:29:43 +0000
Subject: [PATCH] sh: dwarf: prefer _THIS_IP_ to current_text_addr
Message-Id: <20180801182943.22176-1-ndesaulniers@google.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, alexander.levin@verizon.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>

As part of the effort to reduce the code duplication between _THIS_IP_
and current_text_addr(), let's consolidate callers of
current_text_addr() to use _THIS_IP_.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sh/kernel/dwarf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

