From: Hideo Saito <saito@densan.co.jp>
Date: Thu, 03 Jul 2008 01:57:53 +0000
Subject: Re: follow_page() performance regressions
Message-Id: <20080703.105753.68564699.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701052543.GA4726@linux-sh.org>
	<alpine.LFD.1.10.0807010837510.20870@hp.linux-foundation.org>
	<alpine.LFD.1.10.0807010933180.20870@hp.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807010933180.20870@hp.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, saito@densan.co.jp


On Tue, 1 Jul 2008, Linus Torvalds wrote:
> 
> I suspect it could be any of:
> 
>  - actual code generation differences in follow_page() (some SH person 
>    needs to check that)
> 
>  - some cache issue on SH. ZERO_PAGE is a single page at a fixed virtual 
>    address, while it used to populate the page tables with individual 
>    pages. Normally, this should be *better* for caching, but maybe there 
>    is some conflict? What kind of caches does SH have (virtually indexed?)
> 
>  - hackbench relying on follow_page() to populate the page tables, which 
>    it no longer does for anonymous areas (using ZERO_PAGE directly 
>    instead).
> 
>    Again, normally this would speed things up (fewer TLB misses etc), but 
>    if it then causes a new page fault that used to have been covered by 
>    follow_page(), who knows?
> 
> What does hackbench actually do? Anybody?

I am reporter of this problem.
Sorry, my testing was not enough. This problem depends our platform or maybe SH architecture.

When I changed that the code of |goto no_page| and |goto bad_page| to both |goto unlock| at follow_page(), I did not notice that the code of |bad_page:| and |no_page:| was lost by optimizer. In the result, only the size of the text code of kernel became small 0x40 bytes. I think that the cause of this problem is in any of our platform or in the replacement of SH cache.
