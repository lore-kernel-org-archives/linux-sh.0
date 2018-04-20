From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 20 Apr 2018 08:30:32 +0000
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-Id: <20180420083032.GB31275@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180417155407.49c981b3@windsurf.numericable.fr>
In-Reply-To: <20180417155407.49c981b3@windsurf.numericable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp, dalias@libc.org, thomas.petazzoni@free-electrons.com, robin.murphy@arm.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 03:54:07PM +0200, Thomas Petazzoni wrote:
> 
>   dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
> 
> and one to switch to the WARN_ON + if(dev) model. But I don't really
> care either way, so:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Yes, these should be separate patches.  And I actually hope we can
do with the NULL dev check, but that is a different sub-thread.
