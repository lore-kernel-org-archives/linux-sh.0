From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 29 Jun 2014 09:32:54 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <CAMuHMdVjaVuTH=GMM392bz04nn3WxC1FQK33n89rPt0cpJPjsQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Sun, Jun 29, 2014 at 11:10 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/drivers/dma/sh/Makefile
> +++ b/drivers/dma/sh/Makefile
> @@ -1,3 +1,6 @@
> +ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
> +ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
> +
>  obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
>  obj-$(CONFIG_SH_DMAE) += shdma.o
>  shdma-y := shdmac.o

Thanks!

There are a few more subdirectories that could benefit from a similar change.
I'm wondering whether this can be fixed at the drivers/dma/Makefile level,
as these config options were clearly intended to apply to all DMA drivers?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
