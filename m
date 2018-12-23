From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 23 Dec 2018 03:41:20 +0000
Subject: Re: [for-next][PATCH 0/5] tracing: Add string_has_prefix() and usages
Message-Id: <20181223034120.GF11421@danjae.aot.lge.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181222162007.697862256@goodmis.org>
In-Reply-To: <20181222162007.697862256@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, kernel-team@lge.com

On Sat, Dec 22, 2018 at 11:20:07AM -0500, Steven Rostedt wrote:
> I hope everyone is OK with these changes. I pushed to linux-next but I'm
> willing to change them if there are still issues.
> 
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
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> for-next
> 
> Head SHA1: 92b9de3e574bd874188a4e27a8830bb901a08ef8
> 
> 
> Steven Rostedt (VMware) (5):
>       string.h: Add str_has_prefix() helper function
>       tracing: Use str_has_prefix() helper for histogram code
>       tracing: Use str_has_prefix() instead of using fixed sizes
>       tracing: Have the historgram use the result of str_has_prefix() for len of prefix
>       tracing: Use the return of str_has_prefix() to remove open coded numbers

For the series:

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
> ----
>  include/linux/string.h           | 20 ++++++++++++++++++++
>  kernel/trace/trace.c             |  8 +++++---
>  kernel/trace/trace_events.c      |  2 +-
>  kernel/trace/trace_events_hist.c | 35 ++++++++++++++++++-----------------
>  kernel/trace/trace_probe.c       | 17 +++++++++--------
>  kernel/trace/trace_stack.c       |  6 ++++--
>  6 files changed, 57 insertions(+), 31 deletions(-)
