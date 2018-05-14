From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 08:35:40 +0000
Subject: Re: Build regressions/improvements in v4.17-rc5
Message-Id: <CAMuHMdUoDmXZy+fF_-op6Pk8gdaOFDvzvpDOkXcZ3uvTpqVKOg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1526286669-484-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1526286669-484-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Mon, May 14, 2018 at 10:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.17-rc5[1] to v4.17-rc4[3], the summaries are:
>   - build errors: +4/-1

  + /kisskb/src/arch/sh/boards/mach-landisk/setup.c: error: implicit
declaration of function 'ioremap_prot'
[-Werror=implicit-function-declaration]:  => 64:2

sh-randconfig

Probably not a regression, but I haven't seen this one before.

  + error: "__udivdi3" [drivers/mtd/nand/raw/nand.ko] undefined!:  => N/A

m68k-allmodconfig

Patch available.

> [1] http://kisskb.ellerman.id.au/kisskb/head/67b8d5c7081221efa252e111cd52532ec6d4266f/ (244 out of 246 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/75bc37fefc4471e718ba8e651aa74673d4e0a9eb/ (244 out of 246 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
