From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 04 Feb 2010 05:26:14 +0000
Subject: Re: [PATCH 2/3 v3] sh: fix Transfer Size calculation in both DMA drivers
Message-Id: <20100204052614.GD451@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002011958290.4617@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002011958290.4617@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 03, 2010 at 06:47:16PM -0700, Dan Williams wrote:
> Paul Mundt wrote:
> >On Wed, Feb 03, 2010 at 10:58:45AM -0700, Dan Williams wrote:
> >>Dan Williams wrote:
> >>>>arch/sh/drivers/dma/dma-sh.c           |    5 +-
> >>>This bit collides with 9d56dd3b "sh: Mass ctrl_in/outX to 
> >>>__raw_read/writeX conversion." in Paul's tree.  I'm fine with these 
> >>>going through the sh tree with my acked-by modulo that minor nit with 
> >>>the dma_list_mutex comment in 3/3.
> >>The other option would be for me to base async_tx.git/next on top of 
> >>sh.git/master since my tree appears later in the linux-next merge order 
> >> (I would then make sure I merge after Paul during the .34 window). 
> >>The only problem is that this removes the luxury of Paul rebasing the sh 
> >>tree at his leisure (I would need to rebase as well before the result is 
> >>seen by linux-next).  So I'll remain in ack-only mode on this set unless 
> >>Paul signals that sh.git does not rebase.
> >>
> >The SH tree doesn't rebase, so this shouldn't be a problem either way.
> >However, unless there are any dependencies on the bits in your current
> >tree, simply having you Ack the patches and rolling them in to the SH
> >tree seems like the less painful option.
> 
> Ok, I don't have any conflicting dmaengine api updates this cycle so 
> merging the dma bits w/acks through sh.git sounds good to me.
> 
Ok, the versioning has become a bit of a minefield, but the present set
seems to be:

http://patchwork.kernel.org/patch/73811/
http://patchwork.kernel.org/patch/76707/
http://patchwork.kernel.org/patch/76708/

which I think have addressed all of the issues you raised. Since the
next patch series builds on top of these I'll merge these as-is and add
your Acked-by if you have no outstanding concerns.

To keep things more manageable I'll merge these in to a topic branch and
then merge that. That way if there are more complicated changes with the
next batch of updates we can just stack them on top and you should be
able to trivially pull from there without having to worry about all of
the other stuff in my tree (at which point the merge order during the
merge window shouldn't be of any specific concern), and I'll already have
resolved any conflicts in my tree.
