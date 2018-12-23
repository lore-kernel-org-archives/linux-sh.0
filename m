From: Steven Rostedt <rostedt@goodmis.org>
Date: Sun, 23 Dec 2018 00:55:02 +0000
Subject: Re: [for-next][PATCH 0/5] tracing: Add string_has_prefix() and usages
Message-Id: <20181222195502.3951b626@vmware.local.home>
List-Id: <linux-sh.vger.kernel.org>
References: <20181222162007.697862256@goodmis.org>
In-Reply-To: <20181222162007.697862256@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On Sat, 22 Dec 2018 11:20:07 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> They ran through all my tests, althought zero-day-bot had a weird build
> regression in sh, that looks totally unrelated:
> 
>  Regressions in current branch:
> 
>  arch/sh/kernel/dwarf.c:107:26: error: 'dwarf_frame_reg' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:1209:0: error: unterminated argument list invoking macro "WARN_ON"
>  arch/sh/kernel/dwarf.c:226:12: error: 'dwarf_read_encoded_value' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:306:26: error: 'dwarf_lookup_cie' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:38:27: error: 'dwarf_frame_cachep' defined but not used [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:399:12: error: 'dwarf_cfa_execute_insns' defined but not used [-Werror=unused-function]
>  arch/sh/kernel/dwarf.c:41:27: error: 'dwarf_reg_cachep' defined but not used [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:580:22: error: unused variable 'frame' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:581:20: error: unused variable 'cie' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:582:20: error: unused variable 'fde' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:583:20: error: unused variable 'reg' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:584:16: error: unused variable 'addr' [-Werror=unused-variable]
>  arch/sh/kernel/dwarf.c:622:3: error: expected ';' at end of input
>  arch/sh/kernel/dwarf.c:622:3: error: expected declaration or statement at end of input
>  arch/sh/kernel/dwarf.c:622:3: error: 'WARN_ON' undeclared (first use in this function); did you mean 'WMARK_LOW'?
> 
> Pushing to my for-next branch should kick off another run. Let's see
> if it reports that again. Unless someone knows why that happened?


FYI,

Zeroday reported back a successful run of my for-next branch, and did
it again, after I pushed a rebase that added an Acked-by. Thus, I'm
guessing that the above is a simple fluke.

-- Steve
