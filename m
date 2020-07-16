From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 16 Jul 2020 10:54:51 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <f4fcb2e7-eca3-9a70-8e32-e3bf341b62eb@physik.fu-berlin.de>
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
 <20200716102934.GC43129@hirez.programming.kicks-ass.net>
In-Reply-To: <20200716102934.GC43129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: peterz@infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Peter!

On 7/16/20 12:29 PM, peterz@infradead.org wrote:
>> Then Aneesh got a bunch of those patches merged because he needed it for
>> Power, but the rest bitrotted again.
>>
>> Let me rebase/refresh the rest of that and send it out again.
> 
> OK, latest patches here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git mm/tlb
> 
> I'll post once the robot is all green.

Thanks. I just cherry-picked the two patches for SH and applied them on top
of Linus' tree plus the patch 73c348f31b63d28d ("sh: Fix unneeded constructor
in page table allocation") from next-20200710.

The build fails with:

  CC      mm/mmu_gather.o
mm/mmu_gather.c: In function ‘tlb_table_invalidate’:
mm/mmu_gather.c:180:6: error: implicit declaration of function ‘tlb_needs_table_invalidate’; did you mean ‘tlb_table_invalidate’? [-Werror=implicit-function-declaration]
  180 |  if (tlb_needs_table_invalidate()) {
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |      tlb_table_invalidate
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:281: mm/mmu_gather.o] Error 1
make: *** [Makefile:1756: mm] Error 2

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
