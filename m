From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 May 2016 09:24:45 +0000
Subject: Re: Build regressions/improvements in v4.6-rc6
Message-Id: <CAMuHMdUXATNLeSP0m8n9Vyv03VGhffwA_843v+=+goOfauq4uw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1462181021-8889-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1462181021-8889-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Mon, May 2, 2016 at 11:23 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.6-rc6[1] to v4.6-rc5[3], the summaries are:
>   - build errors: +7/-18

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

> [1] http://kisskb.ellerman.id.au/kisskb/head/10264/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10230/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
