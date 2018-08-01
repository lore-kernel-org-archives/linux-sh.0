From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 01 Aug 2018 18:50:06 +0000
Subject: Re: [PATCH] sh: dwarf: prefer _THIS_IP_ to current_text_addr
Message-Id: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180801182943.22176-1-ndesaulniers@google.com>
In-Reply-To: <20180801182943.22176-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Aug 1, 2018 at 11:29 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> As part of the effort to reduce the code duplication between _THIS_IP_
> and current_text_addr(), let's consolidate callers of
> current_text_addr() to use _THIS_IP_.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/sh/kernel/dwarf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
> index 1a2526676a87..bb511e2d9d68 100644
> --- a/arch/sh/kernel/dwarf.c
> +++ b/arch/sh/kernel/dwarf.c
> @@ -599,7 +599,7 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
>          * time this function makes its first function call.
>          */
>         if (!pc || !prev)
> -               pc = (unsigned long)current_text_addr();
> +               pc = _THIS_IP_;
>
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>         /*
> --
> 2.18.0.597.ga71716f1ad-goog
>

Sorry, there's another call site in the arch/sh/ tree
(arch/sh/include/asm/kexec.h#64).  Let me fix both and send as a
single patch in v2.
-- 
Thanks,
~Nick Desaulniers
