From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Dec 2013 14:48:01 +0000
Subject: Re: [PATCH 4/4] sh/kexec: Fix kexec build warning
Message-Id: <CAMuHMdUVfY5UO2tZEzSML9Bhx64VobDdyJQwOgfQ5=2wzxbONQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <594a3d26aac66e9668edc81d7bfb4e801575514f.1386807069.git.geoff@infradead.org>
In-Reply-To: <594a3d26aac66e9668edc81d7bfb4e801575514f.1386807069.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geoff,

On Thu, Dec 12, 2013 at 1:18 AM, Geoff Levand <geoff@infradead.org> wrote:
> Add a cast to a printk argument to suppress a type mismatch compiler warning.
>
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> ---
>  arch/sh/kernel/machine_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
> index 9fea49f..b7e65a8 100644
> --- a/arch/sh/kernel/machine_kexec.c
> +++ b/arch/sh/kernel/machine_kexec.c
> @@ -60,7 +60,7 @@ static void kexec_info(struct kimage *image)
>                        i,
>                        (unsigned int)image->segment[i].mem,
>                        (unsigned int)image->segment[i].mem +
> -                                    image->segment[i].memsz,
> +                      (unsigned int)image->segment[i].memsz,
>                        (unsigned int)image->segment[i].memsz);
>         }
>         printk("  start     : 0x%08x\n\n", (unsigned int)image->start);

Wouldn't it be better to remove all casts and correct the printf-style
format specifiers instead?

  - mem and start are unsigned long, hence use "0x%08lx",
  - memsz is size_t, hence use "0x%08zx".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
