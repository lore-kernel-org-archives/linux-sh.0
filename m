From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 07 Aug 2017 12:41:27 +0000
Subject: Re: Build regressions/improvements in v4.13-rc4
Message-Id: <CAMuHMdWFz93hYRv2NtbnO=P5ZFt_v+cBf7c49Ac4G+Rp6Km75A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1502109558-15917-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1502109558-15917-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Aug 7, 2017 at 2:39 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.13-rc4[1] to v4.13-rc3[3], the summaries are:
>   - build errors: +1/-2

  + /home/kisskb/slave/src/arch/sh/drivers/dma/dma-sh.c: error:
'CONFIG_NR_ONCHIP_DMA_CHANNELS' undeclared here (not in a function):
=> 376:17

sh-randconfig

Some oddity randconfig never hit before.

> [1] http://kisskb.ellerman.id.au/kisskb/head/aae4e7a8bc44722fe70d58920a36916b1043195e/ (all 267 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/16f73eb02d7e1765ccab3d2018e0bd98eb93d973/ (all 267 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
