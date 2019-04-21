From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 21 Apr 2019 17:38:50 +0000
Subject: Re: Build regressions/improvements in v5.1-rc4
Message-Id: <CAMuHMdWGq26GWJidQB8cpQ6HYDCNKqHKEedHf20+ZotexXOEPA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190421171258.12689-1-geert@linux-m68k.org>
In-Reply-To: <20190421171258.12689-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Apr 21, 2019 at 7:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.1-rc4[1] to v5.1-rc3[3], the summaries are:
>   - build errors: +1/-0

  + error: arch/sh/kernel/cpu/sh2/clock-sh7619.o: undefined reference
to `followparent_recalc':  => .data+0x70)

sh4/sh-all{mod,yes}config (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/15ade5d2e7775667cf191cf2f94327a4889f8b9d/ (all 236 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/79a3aaa7b82e3106be97842dedfd8429248896e6/ (all 236 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
