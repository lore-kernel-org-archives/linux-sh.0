From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Wed, 11 May 2011 22:37:23 +0000
Subject: Re: [PATCH] [RFC] remove warning and warning_symbol from struct
Message-Id: <20110511223719.GC1846@nowhere>
List-Id: <linux-sh.vger.kernel.org>
References: <1304709791-4232-1-git-send-email-richard@nod.at>
In-Reply-To: <1304709791-4232-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, oprofile-list@lists.sf.net, oleg@redhat.com, akpm@linux-foundation.org, ying.huang@intel.com, ssp@redhat.com, namhyung@gmail.com, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, robert.richter@amd.com, Ingo Molnar <mingo@elte.hu>

On Fri, May 06, 2011 at 09:23:11PM +0200, Richard Weinberger wrote:
> Both warning and warning_symbol are nowhere used.
> Let's get rid of them.

I have no clue what it was used for. But fine let's assume
it's a leftover of some previous removal.

> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/sh/include/asm/stacktrace.h  |    3 ---
>  arch/sh/kernel/dumpstack.c        |   15 ---------------
>  arch/sh/kernel/perf_callchain.c   |   12 ------------
>  arch/sh/kernel/stacktrace.c       |   13 -------------
>  arch/sh/oprofile/backtrace.c      |   13 -------------

Can you please split your patch in two parts: one for sh and
another for x86?

Thanks.

>  arch/x86/include/asm/stacktrace.h |    3 ---
>  arch/x86/kernel/cpu/perf_event.c  |   13 -------------
>  arch/x86/kernel/dumpstack.c       |   16 ----------------
>  arch/x86/kernel/stacktrace.c      |   13 -------------
>  arch/x86/oprofile/backtrace.c     |   13 -------------
>  10 files changed, 0 insertions(+), 114 deletions(-)
