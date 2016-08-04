From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Aug 2016 12:24:24 +0000
Subject: Re: Build regressions/improvements in v4.7
Message-Id: <CAMuHMdWE26M=w53v0SoYSsxxwtnJz=hvBsz+Ltw_zZ7EE3xCeg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1470312807-30465-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1470312807-30465-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Aug 4, 2016 at 2:13 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.7[1] to v4.7-rc7[3], the summaries are:
>   - build errors: +6/-4

  + /home/kisskb/slave/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_HIGH_MASK' undeclared (first use in this function):  => 98:12
  + /home/kisskb/slave/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_HIGH_SHIFT' undeclared (first use in this function):  =>
145:10, 98:34
  + /home/kisskb/slave/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_LOW_MASK' undeclared (first use in this function):  => 97:21
  + /home/kisskb/slave/src/arch/sh/drivers/dma/dma-sh.c: error:
'CHCR_TS_LOW_SHIFT' undeclared (first use in this function):  =>
97:42, 145:10

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/10646/ (261 out of 263 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10595/ (261 out of 263 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
