From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 10 Jan 2012 05:33:51 +0000
Subject: Re: [PATCH v2 1/3] dmaengine: shdma: modify the DMAC Address Error registration
Message-Id: <20120110053351.GB5299@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0BCA90.3050508@renesas.com>
In-Reply-To: <4F0BCA90.3050508@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 10, 2012 at 02:20:16PM +0900, Shimoda, Yoshihiro wrote:
> +		if (chanirq_res = errirq_res ||
> +		    (errirq_res->flags & IORESOURCE_BITS) =
> +		    IORESOURCE_IRQ_SHAREABLE)
> +			irqflags = IRQF_SHARED;
> +
While not your fault, it seems that there are a few of these cases in
which the irqflags are clobbered rather than added to. Is there some
particular reason why we aren't doing |= IRQF_SHARED on top of the
default IRQF_DISABLED case?
