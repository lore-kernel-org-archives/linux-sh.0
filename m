From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 Jul 2008 16:35:34 +0000
Subject: Re: follow_page() performance regressions
Message-Id: <alpine.LFD.1.10.0807010933180.20870@hp.linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701.132439.68562265.saito@densan.co.jp> <20080701052543.GA4726@linux-sh.org> <alpine.LFD.1.10.0807010837510.20870@hp.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807010837510.20870@hp.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Hideo Saito <saito@densan.co.jp>, linux-sh@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



On Tue, 1 Jul 2008, Linus Torvalds wrote:
> 
>  - some cache issue on SH. ZERO_PAGE is a single page at a fixed virtual 
>    address, while it used to populate the page tables with individual 
>    pages. Normally, this should be *better* for caching, but maybe there 
>    is some conflict? What kind of caches does SH have (virtually indexed?)

Actually, this one is unlikely. ZERO_PAGE _used_ to be problematic on some 
virtually indexed caches, because the same physical page would get mapped 
into multiple places virtually, which in turn then caused some cache or 
TLB conflict or something (I forget - MIPS was the main offender).

But because we now use just the single kernel virtual address for 
accessing the ZERO_PAGE, that really shouldn't matter. Unless the 
particular user of follow_pages() that triggers in this case is doing 
something odd, of course.

		Linus
