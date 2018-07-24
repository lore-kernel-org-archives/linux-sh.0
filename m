From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Jul 2018 20:21:15 +0000
Subject: Re: use the generic dma-noncoherent code for sh V2
Message-Id: <20180724202115.GA4685@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20180724120147.15096-1-hch@lst.de>
In-Reply-To: <20180724120147.15096-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, iommu@lists.linux-foundation.org, Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Ok, there is one more issue with this version.   Wait for a new one
tomorrow.

On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> can you review these patches to switch sh to use the generic
> dma-noncoherent code?  All the requirements are in mainline already
> and we've switched various architectures over to it already.
> 
> Changes since V1:
>  - fixed two stupid compile errors and verified them using a local
>    cross toolchain instead of the 0day buildbot
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
