From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 Jul 2008 15:43:26 +0000
Subject: Re: follow_page() performance regressions
Message-Id: <alpine.LFD.1.10.0807010837510.20870@hp.linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701.132439.68562265.saito@densan.co.jp> <20080701052543.GA4726@linux-sh.org>
In-Reply-To: <20080701052543.GA4726@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Hideo Saito <saito@densan.co.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org



On Tue, 1 Jul 2008, Paul Mundt wrote:
> 
> So yes, the ZERO_PAGE handling in follow_page() is causing the slow-down here.

I suspect it could be any of:

 - actual code generation differences in follow_page() (some SH person 
   needs to check that)

 - some cache issue on SH. ZERO_PAGE is a single page at a fixed virtual 
   address, while it used to populate the page tables with individual 
   pages. Normally, this should be *better* for caching, but maybe there 
   is some conflict? What kind of caches does SH have (virtually indexed?)

 - hackbench relying on follow_page() to populate the page tables, which 
   it no longer does for anonymous areas (using ZERO_PAGE directly 
   instead).

   Again, normally this would speed things up (fewer TLB misses etc), but 
   if it then causes a new page fault that used to have been covered by 
   follow_page(), who knows?

What does hackbench actually do? Anybody?

			Linus
