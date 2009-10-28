From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Oct 2009 09:26:32 +0000
Subject: Re: SH ATAPI IDE Driver
Message-Id: <20091028092632.GB13259@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <32390a840910052042t64346e53w1bfb3473c7b2284b@mail.gmail.com>
In-Reply-To: <32390a840910052042t64346e53w1bfb3473c7b2284b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 28, 2009 at 05:07:23PM +0900, ivy kim wrote:
> > For starters, no new drivers should be written aimed at drivers/ide,
> > libata is what you should be working with instead, aiming your driver at
> > drivers/ata (you can see many other pata drivers there for examples on
> > getting started, including ones that deal with ATAPI).
> >
> Although it's late, thank you for the answer. I managed to make IDE working.
> But this is just PIO mode, and now I'm checking DMA mode but I read
> the following article before, so I want to check if I should use
> latest source code if the below mentioned DMA engine work is done.
> For now, I'm using 'sh-2.6-2009-06-08-ms7724se-2.6.30-rc6'
> 
> Later on, I'll post at linux-ide mailing list...
> 
Yes, the dmaengine bits are merged upstream, although presently it's only
enabled for sh7722 and sh7780. Getting it working for SH7724 should be
pretty trivial, since it shouldn't really need much modification over the
SH7722 support (which you can see in arch/sh/kernel/cpu/sh4a/setup-sh7722.c).

If you fetch any recent kernel (ie, 2.6.31 or later) support is
available, and should give you a stable platform for doing your driver
development on.
