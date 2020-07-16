From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 16 Jul 2020 19:33:17 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <4b29e99d-b402-5b2a-9901-50bbdbe55cd8@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
 <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
 <20200716102934.GC43129@hirez.programming.kicks-ass.net>
 <f4fcb2e7-eca3-9a70-8e32-e3bf341b62eb@physik.fu-berlin.de>
 <20200716110146.GB119549@hirez.programming.kicks-ass.net>
 <008b06d4-1edd-1610-2ee1-6ea402d06114@physik.fu-berlin.de>
 <20200716113720.GC119549@hirez.programming.kicks-ass.net>
 <20200716120440.GD43129@hirez.programming.kicks-ass.net>
 <a2e39d5a-77e9-3038-f117-a33353e93f34@physik.fu-berlin.de>
 <20200716192801.GU10769@hirez.programming.kicks-ass.net>
In-Reply-To: <20200716192801.GU10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 7/16/20 9:28 PM, Peter Zijlstra wrote:
> For some reason I had a whole bunch of junk left in my checkout and had
> to basically: rm `git status -s | awk '{print $2}'`.
> 
> Sorry for the noise.
> 
> OK, let me go try my own patches :-)

FWIW, I just successfully built the "defconfig" configuration without any problems.

Looking forward for the updated patches, although the patch to fix PGTABLE_LEVELS >2
works for me [1].

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=mm/tlb&id19a4bf8dcb42efc278940fb81c288c346b3eda

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
