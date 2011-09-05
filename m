From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 05 Sep 2011 08:10:33 +0000
Subject: Re: [PATCH] dma: shdma: transfer based runtime PM
Message-Id: <Pine.LNX.4.64.1109051007230.1112@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1108181650530.5245@axis700.grange> 
 <1314282386.1606.42.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108251636190.17190@axis700.grange>
  <1314283286.1606.52.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108251648100.17190@axis700.grange>
  <1314292850.1606.88.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108260107550.17190@axis700.grange>
  <1314619909.1606.130.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108291419410.31184@axis700.grange>
  <1314622113.1606.134.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108300906590.19151@axis700.grange>
 <1314698257.1606.159.camel@vkoul-udesk3> <Pine.LNX.4.64.1108301321500.19151@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1108301321500.19151@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Paul Mundt <lethal@linux-sh.org>

Hi Vinod

On Tue, 30 Aug 2011, Guennadi Liakhovetski wrote:

> On Tue, 30 Aug 2011, Vinod Koul wrote:
> 
> > On Tue, 2011-08-30 at 09:12 +0200, Guennadi Liakhovetski wrote:
> > > On Mon, 29 Aug 2011, Vinod Koul wrote:
> > > > > > Something like:
> > > > > > /* since callback is set for last descriptor of chain, we call runtime
> > > > > >  * put for that desc alone
> > > > > >  */
> > > > > > list_for_each_entry_safe(desc, __desc, sh_chan->ld_queue, node) {
> > > > > > 	if (desc->async_tx.callback)
> > > > > > 		pm_runtime_put(device);
> > > > > 
> > > > > Not all dma users have callbacks.
> > > > Do you have such usage today, at least I dont :)
> > > > Nevertheless, in tx_submit adding a simple flag in your drivers
> > > > descriptor structure can tell you whether to call _put() or not. Agreed?
> > > 
> > > Yes, I agree, that one could make this work too. Still, I do not 
> > > understand how and why this is better to the extent, that I have to 
> > > reimplement my patch, retest and resubmit it. Maybe Dan or Paul have an 
> > > opinion on this?
> > But wont it make code look simpler and cleaner, you don't reply on your
> > counters but on pm_runtime infrastructure to do the job.
> 
> Sorry, I see it differently. I don't use any counters in my patch. I'm 
> only checking for empty queue, i.e., I'm just identifying the first 
> descriptor submission and the last completion or termination.
> 
> > You juts need
> > to call _put/_get at right places, which IMO l;ooks lot simpler than
> > current approach
> 
> If we didn't have to check for exact symmetry, then yes, I agree, this 
> would be cleaner. I.e., if we indeed had well-defined entry- and 
> exit-points, which are guaranteed to be called exact same number of times. 
> Like, e.g., with file open() / close() etc. But since we don't have this 
> symmetry, and instead have to add flags and iterate lists, this doesn't 
> look natural and simple to me anymore, sorry.

What about this one? Would you be prepared to take it as is, or you still 
think, that a pm_runtime_get*() on each descriptor submission would be 
better?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
