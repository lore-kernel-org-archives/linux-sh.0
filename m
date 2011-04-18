From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Apr 2011 08:16:23 +0000
Subject: Re: [PATCH 2/2] sh: update SDHI configuration symbols in defconfigs
Message-Id: <20110418081623.GC3720@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152003190.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152003190.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 18, 2011 at 08:49:50AM +0200, Guennadi Liakhovetski wrote:
> On Sat, 16 Apr 2011, Simon Horman wrote:
> 
> > On Fri, Apr 15, 2011 at 08:04:12PM +0200, Guennadi Liakhovetski wrote:
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <damm@opensource.se>
> > > ---
> > >  arch/sh/configs/ecovec24_defconfig  |    2 +-
> > >  arch/sh/configs/sh7757lcr_defconfig |    2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > MMC_TMIO is also present in arch/arm/configs/eseries_pxa_defconfig
> > Should that also be updated?
> 
> No, rather not;) If you look in Kconfig, you'll see, that CONFIG_MMC_TMIO 
> is still there, it just means something _slightly_ different now: it means 
> now an MFD-based TMIO MMC implementation. So, it is still the correct 
> symbol to be used on all platforms, except SH / SH-Mobile SDHI-based.

Thanks, I understand now.

Acked-by: Simon Horman <horms@verge.net.au>

