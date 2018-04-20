From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Apr 2018 09:59:13 +0000
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-Id: <CAMuHMdWwJrUgOjaAX1oUHd+KFUMuUzcH6g29zC2mJX377oAHiA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180418104703.GA12462@infradead.org> <20180418131314.GC3999@w540> <20180420083147.GC31275@infradead.org>
In-Reply-To: <20180420083147.GC31275@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: jacopo mondi <jacopo@jmondi.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Robin Murphy <robin.murphy@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Christoph,

On Fri, Apr 20, 2018 at 10:31 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Apr 18, 2018 at 03:13:14PM +0200, jacopo mondi wrote:
>> As long as it goes for arch/sh, the only user of dma_alloc_coherent()
>> is platform_resource_setup_memory(), and it has been fixed by this
>> patch.
>
> Great!
>
>> Unfortunately, as Thomas pointed out, there are drivers which calls
>> into this with the wrong 'struct device' as the sh_eth one he had fixed.
>
> Yes, we'll need fixes there.  Other DMA ops implementations also look
> at struct device, so they generally are buggy.
>
>> I would then say that as long as it goes for the NULL case, we should be
>> fine now.
>
> Then I'd say skil that part, please.

The major reason for keeping the NULL WARN_ON() checks is to make it
obvious to the developer what is wrong, and fall back to the old behavior.

Without the checks, the kernel will just crash during early startup,
without a clue in the (missing) kernel output, usually leading to a
frustrating bisection experience (if the developer is sufficiently motivated,
at all).

Hence my vote for keeping the checks.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
