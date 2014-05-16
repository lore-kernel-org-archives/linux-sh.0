From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 May 2014 12:25:36 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: Let Genmai multiplatform boot with Genmai DTB
Message-Id: <CAMuHMdUYW=5mmVakBt2iLX0pDQL9dC-+TB++=U0kLNK--AKZMw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
 <1400242216-20848-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1400242216-20848-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 16, 2014 at 2:10 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/arch/arm/mach-shmobile/board-genmai-reference.c
> +++ b/arch/arm/mach-shmobile/board-genmai-reference.c
> @@ -42,7 +42,7 @@ static void __init genmai_add_standard_devices(void)
>  }
>
>  static const char * const genmai_boards_compat_dt[] __initconst = {
> -       "renesas,genmai-reference",
> +       "renesas,genmai",
>         NULL,
>  };

Regardless of my Acked-by for the series (it was done similarly for other
boards), I have a more political question: As there's no more board support
code for "renesas,genmai-reference", this means new kernels won't boot
using an old r7s72100-genmai-reference.dts?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
