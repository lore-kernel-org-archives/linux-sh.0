From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 28 Nov 2013 09:25:50 +0000
Subject: Re: [PATCH 1/3] DMA: shdma: Fix warnings due to improper casts and printk formats
Message-Id: <1385630750.1871.19.camel@smile>
List-Id: <linux-sh.vger.kernel.org>
References: <1385512192-10303-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385512192-10303-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 2013-11-27 at 17:24 +0100, Laurent Pinchart wrote:
> Hi Andriy,
> 
> On Wednesday 27 November 2013 17:03:25 Laurent Pinchart wrote:
> > Hi Andy,
> 
> Sorry for the misspelling.

Nothing to sorry for. Andy is better recognizable name of me in virtual
world, though Andriy is an official one. I forgot to use
@linux.intel.com address in the message, that's why you got it with
different name. Please, continue to use Andy.

[]

> > > > +		"chaining (%zu/%zu)@%lx -> %lx with %p, cookie %d\n",
> > > > +		copy_size, *len, (unsigned long)*src, (unsigned long)*dst,
> > > > +		&new->async_tx, new->async_tx.cookie);
> > > 
> > > Instead of dancing with casting (actually for dma_addr_t it should be
> > > ULL type), we can extend %pa to do this job for us:
> >
> > That sounds good to me. Do you plan to submit a patch ? I'd like to get this
> > series upstream in v3.14.
> 
> Please use the attached patch if it can help speeding things up, and replace 
> the author and SoB line with your name and address.

Okay, will do right now. Thanks.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

