From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Apr 2014 08:42:46 +0000
Subject: Re: [PATCH 0/2] DMA: shdma: add DMA cyclic transfer support
Message-Id: <87wqenav06.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhvnrtkw.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhvnrtkw.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org


Hi Vinod

ping ?

> These patches adds DMA cyclic transfer support on shdma driver
> 
> Kuninori Morimoto (2):
>       DMA: shdma: tidyup callback chunk finder
>       DMA: shdma: add cyclic transfer support
> 
>  drivers/dma/sh/shdma-base.c |   90 +++++++++++++++++++++++++++++++++++--------
>  include/linux/shdma-base.h  |    1 +
>  2 files changed, 75 insertions(+), 16 deletions(-)
> 
> 
> Best regards
> ---
> Kuninori Morimoto
