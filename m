From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 08 Jun 2019 12:26:08 +0000
Subject: Re: [PATCH] sh: dma: Add missing IS_ERR test
Message-Id: <CAMuHMdVGhd3KfRq9F+-Qzc7q5kJyczG1RRQDpgs4FqJpPwK4QA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190607115404.4557-1-embedded24@evers-fischer.de>
In-Reply-To: <20190607115404.4557-1-embedded24@evers-fischer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Rolf,

Thanks for your patch!

On Fri, Jun 7, 2019 at 2:04 PM Rolf Evers-Fischer
<embedded24@evers-fischer.de> wrote:
> get_dma_channel may return ERR_PTR, so a check is added.

It may also return NULL...

> --- a/arch/sh/drivers/dma/dma-api.c
> +++ b/arch/sh/drivers/dma/dma-api.c
> @@ -94,7 +94,7 @@ int get_dma_residue(unsigned int chan)
>         struct dma_info *info = get_dma_info(chan);
>         struct dma_channel *channel = get_dma_channel(chan);
>
> -       if (info->ops->get_residue)
> +       if (!IS_ERR(channel) && (info->ops->get_residue))
>                 return info->ops->get_residue(channel);

... in which case .get_residue() may crash, as some implementations
dereference the passed channel pointer.

Hence !IS_ERR_OR_NULL()?

I didn't check the other callers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
