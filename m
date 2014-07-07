From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 07 Jul 2014 11:07:12 +0000
Subject: Re: renesas-drivers-2014-07-07-v3.16-rc4
Message-Id: <CAMuHMdUUfVcnuNMtk+rP1h_u-X7uaNi2s6oTye4B06GUSJhqKw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVTOabkGyJW-jRxXjtGHdA0W=APoiMYWAtvP3y_auqXKg@mail.gmail.com>
In-Reply-To: <CAMuHMdVTOabkGyJW-jRxXjtGHdA0W=APoiMYWAtvP3y_auqXKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Jul 7, 2014 at 1:05 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Today's version is based on renesas-devel-v3.16-rc4-20140707, and contains
> the following for-next branches:

> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git#asoc/for-next

I had a merge conflict due to commit 7635dd189e6f3d8fb007c7a2e3bf93957a82d009
("local: ASoC: rsnd: fixup rsnd_gen_dma_addr() for Gen1") in Simon's tree.
I assume this was fixed differently in the sound-asoc tree, so I reverted the
local fix in Simon's tree. Is that correct?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
