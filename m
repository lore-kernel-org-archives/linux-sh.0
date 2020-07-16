From: peterz@infradead.org
Date: Thu, 16 Jul 2020 10:29:34 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <20200716102934.GC43129@hirez.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
 <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
 <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
In-Reply-To: <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jul 16, 2020 at 11:40:39AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 15, 2020 at 08:21:27PM +0200, Geert Uytterhoeven wrote:
> 
> > Oh, we actually discussed that:
> > https://lore.kernel.org/linux-mm/20191204133454.GW2844@hirez.programming.kicks-ass.net/
> > but there was no conclusion...
> 
> Urgh.. clearly that fell off the table :-(
> 
> So yes, that patch works, but as I wrote, I think it's still broken.
> Then again, that particular breakage has been there for a long time.
> 
> Ooohh.. I have another whole patch-set that fixes that across
> architectures which I forgot about too:
> 
>   https://lkml.kernel.org/r/20191211120713.360281197@infradead.org
> 
> that actually included the SH fix.
> 
> Then Aneesh got a bunch of those patches merged because he needed it for
> Power, but the rest bitrotted again.
> 
> Let me rebase/refresh the rest of that and send it out again.

OK, latest patches here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git mm/tlb

I'll post once the robot is all green.
