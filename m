From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 May 2014 14:46:46 +0000
Subject: Re: [PATCH 0/6] DMA: shdma: Increase build test coverage with COMPILE_TEST
Message-Id: <7667058.GOII0C0uGa@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1399935736-16854-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1399935736-16854-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday 13 May 2014 01:02:10 Laurent Pinchart wrote:
> Hello,
> 
> This patch series increases build test coverage for the Renesas shdma driver
> by enabling driver compilation with COMPILE_TEST. To avoid introducing new
> warnings during bisection the series starts with fixes for warnings
> produced when compiling the driver on non-Renesas platforms.
> 
> Vinod or Dan, could you please pick this up for v3.16 ? The patches have
> already been posted two kernel versions ago, I'd like to avoid missing yet
> another merge window.

Ping ?

> Laurent Pinchart (6):
>   DMA: shdmac: Keep #include sorted alphabetically
>   DMA: shdmac: Include linux/err.h
>   DMA: sudmac: Keep #include sorted alphabetically
>   DMA: sudmac: Include linux/err.h
>   DMA: rcar-hpbdma: Include linux/err.h
>   DMA: shdma: Enable driver compilation with COMPILE_TEST
> 
>  drivers/dma/sh/Kconfig       |  2 +-
>  drivers/dma/sh/rcar-hpbdma.c |  1 +
>  drivers/dma/sh/shdmac.c      | 15 ++++++++-------
>  drivers/dma/sh/sudmac.c      |  7 ++++---
>  4 files changed, 14 insertions(+), 11 deletions(-)

-- 
Regards,

Laurent Pinchart

