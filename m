From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Sep 2016 08:23:22 +0000
Subject: Re: Build regressions/improvements in v4.8-rc6
Message-Id: <CAMuHMdXScEXTu7LqUngVG4ZyGnTnayvMRvJN1Y5PqG1P=jnY5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1473668530-11348-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1473668530-11348-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Sep 12, 2016 at 10:22 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.8-rc6[1] to v4.8-rc5[3], the summaries are:
>   - build errors: +3/-1

  + /home/kisskb/slave/src/arch/sh/include/asm/atomic-llsc.h: error:
'asm' operand has impossible constraints:  => 80:1, 79:1, 73:1, 72:1,
78:1
  + /home/kisskb/slave/src/arch/sh/include/asm/atomic-llsc.h: error:
can't find a register in class 'R0_REGS' while reloading 'asm':  =>
79:1, 73:1, 72:1, 80:1, 78:1

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/10882/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10840/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
