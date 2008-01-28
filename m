From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jan 2008 09:09:04 +0000
Subject: Re: set_dma_addr missing ?
Message-Id: <20080128090904.GA8404@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
In-Reply-To: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 28, 2008 at 09:48:59AM +0100, Francis Moreau wrote:
> On Jan 28, 2008 3:47 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Sat, Jan 26, 2008 at 10:02:02PM +0100, Francis Moreau wrote:
> > > Sorry to be blind but I can't figure out why this function is missing
> > > for SH architecture ?
> > >
> > It's not "missing", it's only enabled if you specifically request support
> > for the ISA DMA API wrapper. It's a total kludge, since the SH DMAC has
> > very little in common with how ISA DMA works, but it's provided for
> > compatability anyways. If you're trying to use this API in a driver,
> > you're almost definitely doing the wrong thing.
> 
> But what's the other alternative ?
> 
> I have a DMA controller, which has very little in common with ISA DMA
> as you said.
> I'd like to use it from a generic driver. Which API should I use then ?
> 
Well, there are two options, either using the existing SH DMA API, or
trying to hook something in through the dmaengine API. The latter is the
way that we'll be moving in the near future, but we do still need to keep
compatability with the existing SH DMA API around in order to avoid
breaking the existing in-tree users.

You may wish to poke around arch/sh/drivers/dma/. There are lots of
greppable things you can find in the rest of tree that show the API,
in-tree users, etc. Post if you have any problems.
