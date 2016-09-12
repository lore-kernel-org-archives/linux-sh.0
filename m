From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 12 Sep 2016 10:48:09 +0000
Subject: Re: Build regressions/improvements in v4.8-rc6
Message-Id: <20160912104809.GP10153@twins.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1473668530-11348-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXScEXTu7LqUngVG4ZyGnTnayvMRvJN1Y5PqG1P=jnY5A@mail.gmail.com>
In-Reply-To: <CAMuHMdXScEXTu7LqUngVG4ZyGnTnayvMRvJN1Y5PqG1P=jnY5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Sep 12, 2016 at 10:23:22AM +0200, Geert Uytterhoeven wrote:
> On Mon, Sep 12, 2016 at 10:22 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v4.8-rc6[1] to v4.8-rc5[3], the summaries are:
> >   - build errors: +3/-1
> 
>   + /home/kisskb/slave/src/arch/sh/include/asm/atomic-llsc.h: error:
> 'asm' operand has impossible constraints:  => 80:1, 79:1, 73:1, 72:1,
> 78:1
>   + /home/kisskb/slave/src/arch/sh/include/asm/atomic-llsc.h: error:
> can't find a register in class 'R0_REGS' while reloading 'asm':  =>
> 79:1, 73:1, 72:1, 80:1, 78:1
> 

https://lkml.kernel.org/r/20160905124027.306155176@infradead.org

Should fix that I think, I'll try and get that merged.
