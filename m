From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 10 Nov 2008 10:41:13 +0000
Subject: Re: repeated oops under load on SH4 system
Message-Id: <20081110104113.GC22067@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <fd0635d10811040431l45e7b41fvee0a78650b15bacc@mail.gmail.com>
In-Reply-To: <fd0635d10811040431l45e7b41fvee0a78650b15bacc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 10, 2008 at 07:38:40PM +0900, Yoshihiro Shimoda wrote:
> Paul Mundt wrote:
> > On Mon, Nov 10, 2008 at 05:11:59PM +0900, Paul Mundt wrote:
> >> On Mon, Nov 10, 2008 at 05:06:23PM +0900, Paul Mundt wrote:
> >>> This suggests you are getting a TLB miss on various fixmap entries. Based
> >>> on your call chain, these are related to the cache colouring in the page
> >>> copying. update_mmu_cache() specifically faults the translation in, so
> >>> you should not be making it all the way up to the TLB miss handler in the
> >>> first place. This points to something evicting the entry from the TLB
> >>> during your copy, which while it is not something I have seen in
> >>> practice, is interesting to know that it remains a possibility under
> >>> other workloads. A simple but expensive fix for this would be blowing out
> >>> the TLB and speculatively bumping up the UTLB replace boundary prior to
> >>> pre-faulting the fixmap translation. I'll look at this some more over the
> >>> next couple days and send you a patch for testing.
> >> Now I remember where I saw this before.. try this patch:
> >>
> >> http://marc.info/?l=linux-sh&m0400865707505&w=2
> >>
> >> There was never any feedback on it, and I was not able to reproduce the
> >> issues.
> > 
> > Updated version, against current git:
> 
> I had a just similar problem today, too. When I used sh7785lcr board,
> it output following log.
> But a problem did not occur when I used this patch.
> Thank you very much!
> 
Interesting, I've been running on the same board without incident. Thanks
for testing, I'll add this to the 2.6.28 queue!
