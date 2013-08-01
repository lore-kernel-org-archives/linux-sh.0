From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 01 Aug 2013 21:26:06 +0000
Subject: Re: [PATCH] tmio_mmc_dma: fix PIO fallback on SDHI
Message-Id: <51FAD26E.2020704@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308020117.17897.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308020117.17897.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, g.liakhovetski@gmx.de, ian@mnementh.co.uk, cjb@laptop.org
Cc: linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

Hello.

On 08/02/2013 01:17 AM, Sergei Shtylyov wrote:

> I'm testing SH-Mobile SDHI driver in DMA mode with a  new DMA controller  using
> 'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code falls back
> to PIO but all commands time out after that.  It turned out that the fallback
> code calls tmio_mmc_enable_dma() with RX/TX channels already freed and pointers
> to them cleared, so that the function bails out early instead  of clearing the
> DMA bit in the CTL_DMA_ENABLE register.  Fixing the RX/TX channel check so that
> it takes place only when enabling DMA helps with the PIO fallback.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Forgot to mark the patch for stable. The bug was introduced by commit 
162f43e31c5a376ec16336e5d0ac973373d54c89 (mmc: tmio: fix a deadlock) back in 
2011 -- should probably have mentioned that in the changelog too.

WBR, Sergei

