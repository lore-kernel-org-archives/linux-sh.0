From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 11 Jun 2014 13:23:30 +0000
Subject: [PATCH] arm/ftrace: Fix function_return_addr() to function_return_address()
Message-Id: <20140611092330.7930eff2@gandalf.local.home>
List-Id: <linux-sh.vger.kernel.org>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-2-git-send-email-takahiro.akashi@linaro.org>
 <CAMuHMdWs9i4pBNbn-RTpv_-K5W7YGED=KtEtFSci=7YHdNKpfw@mail.gmail.com>
In-Reply-To: <CAMuHMdWs9i4pBNbn-RTpv_-K5W7YGED=KtEtFSci=7YHdNKpfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The clean up of CALLER_ADDR*() functions required the archs to either
use the default __builtin_return_address(X) (where X > 0) or override
it with something the arch can use. To override it, the arch would
define function_return_address(x).

The arm architecture requires this to be redefined but instead of
defining function_return_address(x) it defined function_return_addr(x).

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
----
diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index eb577f4..39eb16b 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -52,7 +52,7 @@ extern inline void *return_address(unsigned int level)
 
 #endif
 
-#define ftrace_return_addr(n) return_address(n)
+#define ftrace_return_address(n) return_address(n)
 
 #endif /* ifndef __ASSEMBLY__ */
 
