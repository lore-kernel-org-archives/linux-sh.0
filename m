From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Jun 2014 11:09:32 +0000
Subject: Re: [kbuild] [slave-dma:for-linus 55/57] drivers/dma/sh/rcar-hpbdma.c:627:10-15: ERROR: iterator var
Message-Id: <2296161.9WoPSnLurk@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Monday 02 June 2014 10:33:42 Dan Carpenter wrote:
> tree:   git://git.infradead.org/users/vkoul/slave-dma.git for-linus
> head:   654fa24965aafcb4bb8a1a14400c5ecea3be76b6
> commit: ebc6d2d9c8cd48c351da84dd467c0edddc149ded [55/57] dmaengine: shdma:
> Enable driver compilation with COMPILE_TEST
> >> drivers/dma/sh/rcar-hpbdma.c:627:10-15: ERROR: iterator variable bound on
> >> line 626 cannot be NULL
> --
> >> drivers/dma/sh/shdma-base.c:812:7-12: ERROR: iterator variable bound on
> >> line 808 cannot be NULL
> --
> >> drivers/dma/sh/shdmac.c:581:10-15: ERROR: iterator variable bound on line
> >> 580 cannot be NULL
> --
> >> drivers/dma/sh/sudmac.c:303:10-15: ERROR: iterator variable bound on line
> >> 302 cannot be NULL
>
> Please consider folding the attached diff :-)

The shdma_for_each_chan iterator can in theory iterate over NULL elements. 
I'll need to check whether it can happen in practice before applying the 
proposed fixes.

-- 
Regards,

Laurent Pinchart

