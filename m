From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 31 Jul 2018 06:06:13 +0000
Subject: Re: use the generic dma-noncoherent code for sh V3
Message-Id: <877elcrlbe.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20180725094043.32443-1-hch@lst.de>
In-Reply-To: <20180725094043.32443-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 18:40:38 +0900,
Christoph Hellwig wrote:
> 
> Hi all,
> 
> can you review these patches to switch sh to use the generic
> dma-noncoherent code?  All the requirements are in mainline already
> and we've switched various architectures over to it already.
> 
> Changes since V2:
>  - drop a now obsolete export
> 
> Changes since V1:
>  - fixed two stupid compile errors and verified them using a local
>    cross toolchain instead of the 0day buildbot

Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>

-- 
Yosinori Sato
