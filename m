From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 09 Oct 2013 17:15:01 +0000
Subject: Re: [PATCH 1/2] rcar-hpbdma: remove shdma_free_irq() calls
Message-Id: <52559CCC.4040809@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201309260228.37765.sergei.shtylyov@cogentembedded.com> <20130926021417.GC18396@verge.net.au> <20131003040031.GA7925@verge.net.au>
In-Reply-To: <20131003040031.GA7925@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com
Cc: Simon Horman <horms@verge.net.au>, dan.j.williams@intel.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 03-10-2013 6:00, Simon Horman wrote:

>>> Commit c1c63a14f4f2419d093acd7164eccdff315baa86 (DMA: shdma: switch to managed
>>> resource allocation) got rid of shdma_free_irq() but  unfortunately got merged
>>> later than commit c4f6c41ba790bbbfcebb4c47a709ac8ff1fe1af9 (dma: add driver for
>>> R-Car HPB-DMAC), so that the HPB-DMAC driver retained the calls and got broken:

>>> drivers/dma/sh/rcar-hpbdma.c: In function `hpb_dmae_alloc_chan_resources':
>>> drivers/dma/sh/rcar-hpbdma.c:435: error: implicit declaration of function
>>> `shdma_free_irq'

>>> Fix this compilation error by removing the remaining shdma_free_irq() calls.

>> Tested-by: Simon Horman <horms+renesas@verge.net.au>

>>> Reported-by: Simon Horman <horms@verge.net.au>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Vinod, could you consider taking this and the following patch
> as a fix for v3.12?

    Vinod, may I ask when these regression (induced by you) fixes gets merged?

WBR, Sergei

