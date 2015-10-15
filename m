From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Oct 2015 17:09:21 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Wait for IRQs completion when freeing channel
Message-Id: <3467273.UOXqFaOy4p@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442233573-26684-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Lars,

On Thursday 15 October 2015 09:35:31 Lars-Peter Clausen wrote:
> On 10/15/2015 05:56 AM, Vinod Koul wrote:
> > On Wed, Oct 14, 2015 at 01:02:22PM +0200, Lars-Peter Clausen wrote:
> >> On 10/14/2015 12:50 PM, Vinod Koul wrote:
> >>> On Thu, Oct 08, 2015 at 04:51:30PM +0200, Lars-Peter Clausen wrote:
> >>>>> The DMA engine API states that
> >>>>> 
> >>>>>    * device_terminate_all
> >>>>>    
> >>>>>      - Aborts all the pending and ongoing transfers on the channel
> >>>>>      - This command should operate synchronously on the channel,
> >>>>>        terminating right away all the channels
> >>>>> 
> >>>>> I wonder how to interpret "synchronously" here, should terminate_all()
> >>>>> wait for termination to be complete ? In that case it wouldn't be
> >>>>> valid to call it from non-sleepable context.
> >>>> 
> >>>> We need to extend the DMAengine API to allow synchronization. The issue
> >>>> is not only the IRQ itself but also the tasklet that can be scheduled
> >>>> from the IRQ. Since we in some cases (e.g. audio underrun) call
> >>>> terminate_all() from within the completion callback that runs in the in
> >>>> the tasklet we can't synchronize to the tasklet in
> >>>> dmaengine_terminate_all(). We need a separate API call to handle this.
> >>>> And then maybe have a helper like dmaengine_terminate_all_sync() that
> >>>> terminates and synchronizes. And in cases where terminate_all is called
> >>>> from a context where it can't synchronize the new API needs to be
> >>>> called separately before freeing the resources.
> >>> 
> >>> Right now the terminate_all() is intended for syncronous behaviour which
> >>> prevents it from being invoked in the callback.
> >> 
> >> That does not match reality though. Which means the documentation is
> >> wrong. Pretty much all drivers implement a non-synchronous terminate
> >> function and there are users that rely on this.
> > 
> > Lets fix that then :)
> > 
> > We should have both option IMHO, as I think we have both types of
> > usages... Care to send a patch?
> 
> Yeah, it's on my TODO list for the next month, since I need the synchronous
> terminate elsewhere as well.

The DMA engine API needs lots of love. Should we try to synchronize on all the 
open issues to define a coherent direction ?

-- 
Regards,

Laurent Pinchart

