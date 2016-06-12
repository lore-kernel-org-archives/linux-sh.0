From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 12 Jun 2016 09:03:13 +0000
Subject: Re: [PATCH] sh: system call wire up
Message-Id: <CAMuHMdVOFu3TzZjcAS5+JWRh4gCWr_SKoYJYhE7aOPaJpLd1tQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1465664789-3976-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465664789-3976-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Jun 11, 2016 at 7:06 PM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/include/uapi/asm/unistd_32.h | 16 +++++++++++++++-
>  arch/sh/include/uapi/asm/unistd_64.h | 16 +++++++++++++++-
>  arch/sh/kernel/syscalls_32.S         | 14 ++++++++++++++
>  arch/sh/kernel/syscalls_64.S         | 14 ++++++++++++++
>  4 files changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
> index d13a1d6..c801bde 100644
> --- a/arch/sh/include/uapi/asm/unistd_32.h
> +++ b/arch/sh/include/uapi/asm/unistd_32.h
> @@ -380,7 +380,21 @@
>  #define __NR_process_vm_writev 366
>  #define __NR_kcmp              367
>  #define __NR_finit_module      368
> +#define __NR_sched_getattr     369
> +#define __NR_sched_setattr     370
> +#define __NR_renameat2         371
> +#define __NR_seccomp           372

Doesn't seccomp need architecture support before it can be enabled?

That's the reason why I haven't wired it up on m68k yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
