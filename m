From: "Francis Moreau" <francis.moro@gmail.com>
Date: Mon, 28 Jan 2008 08:48:59 +0000
Subject: Re: set_dma_addr missing ?
Message-Id: <38b2ab8a0801280048g21c999b6t357b646f62d8dc50@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
In-Reply-To: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul,

On Jan 28, 2008 3:47 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sat, Jan 26, 2008 at 10:02:02PM +0100, Francis Moreau wrote:
> > Sorry to be blind but I can't figure out why this function is missing
> > for SH architecture ?
> >
> It's not "missing", it's only enabled if you specifically request support
> for the ISA DMA API wrapper. It's a total kludge, since the SH DMAC has
> very little in common with how ISA DMA works, but it's provided for
> compatability anyways. If you're trying to use this API in a driver,
> you're almost definitely doing the wrong thing.

But what's the other alternative ?

I have a DMA controller, which has very little in common with ISA DMA
as you said.
I'd like to use it from a generic driver. Which API should I use then ?

Thanks
-- 
Francis
