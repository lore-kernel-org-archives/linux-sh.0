From: peterz@infradead.org
Date: Thu, 16 Jul 2020 11:37:20 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <20200716113720.GC119549@hirez.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
 <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
 <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
 <20200716102934.GC43129@hirez.programming.kicks-ass.net>
 <f4fcb2e7-eca3-9a70-8e32-e3bf341b62eb@physik.fu-berlin.de>
 <20200716110146.GB119549@hirez.programming.kicks-ass.net>
 <008b06d4-1edd-1610-2ee1-6ea402d06114@physik.fu-berlin.de>
In-Reply-To: <008b06d4-1edd-1610-2ee1-6ea402d06114@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jul 16, 2020 at 01:03:36PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Peter!
> 
> On 7/16/20 1:01 PM, peterz@infradead.org wrote:
> >> The build fails with:
> >>
> >>   CC      mm/mmu_gather.o
> >> mm/mmu_gather.c: In function ‘tlb_table_invalidate’:
> >> mm/mmu_gather.c:180:6: error: implicit declaration of function ‘tlb_needs_table_invalidate’; did you mean ‘tlb_table_invalidate’? [-Werror=implicit-function-declaration]
> >>   180 |  if (tlb_needs_table_invalidate()) {
> >>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >>       |      tlb_table_invalidate
> >> cc1: some warnings being treated as errors
> >> make[1]: *** [scripts/Makefile.build:281: mm/mmu_gather.o] Error 1
> >> make: *** [Makefile:1756: mm] Error 2
> > 
> > *sigh*, thanks, I'll go dig out the local cross compiler set then.
> 
> FWIW, I recommend keeping a Debian box at hand where installing the cross-compiler
> is a matter of running "apt install gcc-sh4-linux-gnu" ;-).

I happen to have Debian on most of my machines ;-) And I used to
crosstool build my own toolchains for a while, but these days I mostly
just fetch them from kernel.org, since they're being kept up-to-date
fairly often.

$ /opt/cross/bin/sh4-linux-gcc --version
sh4-linux-gcc (GCC) 10.1.0
