From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 13:20:49 +0000
Subject: Re: [PATCH v4 2/7] ARM: shmobile: ape6evm: add MMCIF support
Message-Id: <20130710132049.GA13716@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307101003340.6609@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307101003340.6609@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 10, 2013 at 10:13:08AM +0200, Guennadi Liakhovetski wrote:
> Add MMCIF support to the APE6EVM board in PIO mode only. Power supply is
> fixed for now, eventually support for the tps80032 regulator, also
> supplying both VDD and VccQ to the MMCIF slot should be added to APE6EVM.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> ---
> 
> v4: dropped DMA support
> 
> Hi Simon, this patch is again for the APE6EVM state before the "ARM: 
> shmobile: ape6evm: add SDHI interfaces" patch. As discussed with you, you 
> prefer to regenerate your tree with this patch applied first, and the 
> "SDHI" one on top, to fix the regulator issue, that emerged due to the 
> reversed commit order. After this patch applied, the original SDHI patch 
> version should be used.

Thanks, and sorry once again for messing things up.

I have done the following:

1. Dropped "ARM: shmobile: ape6evm: add SDHI interfaces"
2. Applied this patch
3. Applied the original (v3) version of "ARM: shmobile: ape6evm: add SDHI
   interfaces"

These changes are queued up for v3.12 in the boards branch and
should appear on renesas-next-20130710v2.
