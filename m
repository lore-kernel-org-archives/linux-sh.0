From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jul 2014 08:32:09 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <20140711083208.GA12420@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 10, 2014 at 05:42:13PM +0200, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Thursday 10 July 2014 20:39:29 Vinod Koul wrote:
> > On Thu, Jul 10, 2014 at 02:25:58PM +0200, Laurent Pinchart wrote:
> > > On Thursday 03 July 2014 10:48:34 Wolfram Sang wrote:
> > > > Hi,
> > > > 
> > > > > With dynamic debug, these flags dont make much sense unless you want
> > > > > something to be printed *always* during boot.
> > > > 
> > > > Yes, this was exactly what I wanted.
> > > 
> > > Why is that ? My understanding is that the purpose of the
> > > CONFIG_DMADEVICES_DEBUG option is to enable debug messages for debugging.
> > > As it requires recompiling the kernel, wouldn't dynamic printk be a
> > > better alternative ?
> > 
> > No it wont. Pls see the discussion.
> > 
> > Lots of dmanegine device gets used at boot, so for testing those scenarios
> > it will help to enable debug!
> 
> OK, that's the point I've missed. I agree with the patch then.

Hi,

in order to try and create a smoother path for changes in this area to land
I have pushed them to the shdma-for-v3.17 branch of my renesas tree
on kernel.org. It is merged into the devel and next branches of that tree
and should appear in linux-next in the near future.

My intention is to send a pull-request for this branch once it has sat
in next for a short time. I hope that this approach is useful to all parties.

