From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Aug 2011 07:12:07 +0000
Subject: Re: [PATCH] dma: shdma: transfer based runtime PM
Message-Id: <Pine.LNX.4.64.1108300906590.19151@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1108181650530.5245@axis700.grange> 
 <1314282386.1606.42.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108251636190.17190@axis700.grange>
  <1314283286.1606.52.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108251648100.17190@axis700.grange>
  <1314292850.1606.88.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108260107550.17190@axis700.grange>
  <1314619909.1606.130.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108291419410.31184@axis700.grange>
 <1314622113.1606.134.camel@vkoul-udesk3>
In-Reply-To: <1314622113.1606.134.camel@vkoul-udesk3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Paul Mundt <lethal@linux-sh.org>

On Mon, 29 Aug 2011, Vinod Koul wrote:

> On Mon, 2011-08-29 at 14:21 +0200, Guennadi Liakhovetski wrote:
> > On Mon, 29 Aug 2011, Vinod Koul wrote:
> > 
> > > On Fri, 2011-08-26 at 01:11 +0200, Guennadi Liakhovetski wrote:
> > > > On Thu, 25 Aug 2011, Koul, Vinod wrote:
> > > > > Wont it be easy to to do:
> > > > > - pm_runtime_get() in each submit
> > > > > - pm_runtime_put() in each callback
> > > > > Normal case above would work just fine
> > > > > - In terminate case, count the number of issued transactions, and call
> > > > > pm_runtime_put() for each canceled transaction
> > > > > (i am assuming that for each timeout error, the client will call
> > > > > terminate)
> > > > 
> > > > As I said, this won't be very easy to do this in a robust way. You'd have 
> > > > to scan your list of DMA blocks and see, which of them belong to one 
> > > > descriptor, and once you reach the end of that descriptor, issue a put(). 
> > > > Perhaps, this can be done, but my choice went to the currently presented 
> > > > solution.
> > > If you count the number of descriptor submitted in your submitted list
> > > and call _put for each, I see no reason why it wont be simple and better
> > > than current approach.
> > 
> > Sorry, I thought, you wanted to avoid extra counting, because runtime-pm 
> > counts by itself. Now you propose to count...
> see below it doesn't count but iterate thru list

Yes, sorry, iterating is a better word, but I actually meant "counting" in 
a broad sense, of which "iterating" is a particular case:-)

> > > Something like:
> > > /* since callback is set for last descriptor of chain, we call runtime
> > >  * put for that desc alone
> > >  */
> > > list_for_each_entry_safe(desc, __desc, sh_chan->ld_queue, node) {
> > > 	if (desc->async_tx.callback)
> > > 		pm_runtime_put(device);
> > 
> > Not all dma users have callbacks.
> Do you have such usage today, at least I dont :)
> Nevertheless, in tx_submit adding a simple flag in your drivers
> descriptor structure can tell you whether to call _put() or not. Agreed?

Yes, I agree, that one could make this work too. Still, I do not 
understand how and why this is better to the extent, that I have to 
reimplement my patch, retest and resubmit it. Maybe Dan or Paul have an 
opinion on this?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
