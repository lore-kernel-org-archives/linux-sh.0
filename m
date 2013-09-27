From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Sep 2013 04:54:13 +0000
Subject: Re: [PATCH v4 2/2] ARM: shmobile: BOCK-W: enable DMA for SDHI0
Message-Id: <20130927045413.GA23732@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201308250133.17530.sergei.shtylyov@cogentembedded.com>
 <201308250136.38922.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308250136.38922.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Aug 25, 2013 at 01:36:38AM +0400, Sergei Shtylyov wrote:
> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Pass HPB-DMA slave IDs in the SDHI0 platform data to enable DMA in the SDHI
> driver.
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: removed #include <mach/dma.h>]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, queued up for v3.13.

I believe that a defconfig update is required in order
for this feature to be used when compiling with the defconfig.
If so please provide a defconfig patch.

Thanks.
