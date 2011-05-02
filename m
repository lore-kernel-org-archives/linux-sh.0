From: Simon Horman <horms@verge.net.au>
Date: Mon, 02 May 2011 22:39:39 +0000
Subject: Re: [PATCH 1/2] mmc: tmio: Allow SDHI MMC to use multiple IRQ
Message-Id: <20110502223935.GA8347@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1303890238-8372-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1303890238-8372-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 03, 2011 at 07:05:56AM +0900, Simon Horman wrote:
> On Mon, May 02, 2011 at 09:21:37PM +0900, Magnus Damm wrote:

[ snip ]

> > If we break out the IRQ part of the code we can also easily modify the
> > SDHI code to get rid of the IRQF_TRIGGER_FALLING flag that isn't
> > working on GIC-enabled platforms like AG5. Such a break out would also
> > remove the need for any array of interrupts and TMIO_MMC_MAX_IRQS.
> 
> I noticed that your original implementation didn't have an array of
> interrupts.  Which seems to basically mean that free_irq() can't be called
> in tmio_mmc_host_remove() (or anywhere else on removal). What am I missing?

I see that you answered that witha  patch.
