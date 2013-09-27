From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Sep 2013 04:55:06 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: Marzen: enable DMA for SDHI0
Message-Id: <20130927045506.GB23732@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201308252143.33458.sergei.shtylyov@cogentembedded.com>
 <201308252147.27210.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308252147.27210.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Aug 25, 2013 at 09:47:26PM +0400, Sergei Shtylyov wrote:
> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
> driver.
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: removed #include <mach/dma.h>]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, queued up for v3.13.

Please send along a defconfig update as you mentioned you would yesterday.

Thanks.

