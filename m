From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 18 Nov 2012 09:20:42 +0000
Subject: Re: Build regressions/improvements in v3.7-rc6
Message-Id: <CAMuHMdXuoAhW=CLogzprPe+6=8Oe5y0J6SuZnYKQzhMv=dpuTg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1353230222-3464-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1353230222-3464-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Nov 18, 2012 at 10:17 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.7-rc6 to v3.7-rc5[3], the summaries are:
>   - build errors: +2/-12

Just some broken dependencies, I guess:

2 regressions:
  + arch/powerpc/sysdev/mpic.c: error: case label does not reduce to
an integer constant:  => 890:9, 898:9, 886:9, 894:9

powerpc/powerpc-randconfig

  + error: "__ashrdi3" [fs/ext4/ext4.ko] undefined!:  => N/A

sh4/sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5628/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5614/ (all 117 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
