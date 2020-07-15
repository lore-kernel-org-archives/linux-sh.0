From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2020 18:21:27 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de> <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
In-Reply-To: <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, Jul 15, 2020 at 6:18 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 7/15/20 4:37 PM, John Paul Adrian Glaubitz wrote:
> > Okay, kernel 5.0.0 does not suffer from this bug. So I should be able to bisect
> > this particular issue.
> >
> > I'm glad I don't have to start bisecting with earlier kernels because these
> > won't build easily with my current toolchain based on gcc-9.
> >
> > Will report once I found the bad commit that introduced the problem.
>
> Found the culprit:
>
> c5b27a889da92f4a969d61df77bd4f79ffce57c9 is the first bad commit
> commit c5b27a889da92f4a969d61df77bd4f79ffce57c9
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Sep 4 14:45:04 2018 +0200
>
>     sh/tlb: Convert SH to generic mmu_gather
>
>     Generic mmu_gather provides everything SH needs (range tracking and
>     cache coherency).
>
>     No change in behavior intended.
>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Andy Lutomirski <luto@kernel.org>
>     Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>     Cc: Borislav Petkov <bp@alien8.de>
>     Cc: Dave Hansen <dave.hansen@linux.intel.com>
>     Cc: H. Peter Anvin <hpa@zytor.com>
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Cc: Nick Piggin <npiggin@gmail.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Rich Felker <dalias@libc.org>
>     Cc: Rik van Riel <riel@surriel.com>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
>  arch/sh/include/asm/pgalloc.h |   9 +++
>  arch/sh/include/asm/tlb.h     | 130 +-----------------------------------------
>  2 files changed, 10 insertions(+), 129 deletions(-)
>
> CC'ing the author (Peter Zijlstra <peterz@infradead.org>).

Oh, we actually discussed that:
https://lore.kernel.org/linux-mm/20191204133454.GW2844@hirez.programming.kicks-ass.net/
but there was no conclusion...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
