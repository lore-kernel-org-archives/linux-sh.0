From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 10:59:06 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen: Include mmc/host.h
Message-Id: <20130213105905.GB22623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360748750-11911-1-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1302131052140.18535@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302131052140.18535@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 13, 2013 at 10:52:31AM +0100, Guennadi Liakhovetski wrote:
> On Wed, 13 Feb 2013, Simon Horman wrote:
> 
> > mmc/host.h provides MMC_CAP_SD_HIGHSPEED which is used in board-marzen.c
> > 
> > This resolves a build problem observed when compiling with
> > "mmc: tmio: remove unused and deprecated symbols" applied.
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, I have applied it to the boards3 branch.
