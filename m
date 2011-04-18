From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Apr 2011 07:56:46 +0000
Subject: Re: [PATCH 1/2] sh: fix SD / MMC configuration dependencies on
Message-Id: <20110418075643.GA3720@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104152000450.18593@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1104152000450.18593@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 18, 2011 at 08:43:03AM +0200, Guennadi Liakhovetski wrote:
> On Sat, 16 Apr 2011, Simon Horman wrote:
> 
> > On Fri, Apr 15, 2011 at 08:03:17PM +0200, Guennadi Liakhovetski wrote:
> > > Update CONFIG_MMC_TMIO to the new CONFIG_MMC_SDHI symbol and fix
> > > MMCIF to also function in modular builds for ecovec.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <damm@opensource.se>
> > 
> > Acked-by: Simon Horman <horms@verge.net.au>
> > 
> > It is curious that these config options are only used by ecovec.
> > Is it because SDHI support is unconditional on other platforms - eg ap4evb?
> 
> Yes, other platforms just happen to use other methods to enable and 
> disable different platform devices.

Thanks for the confirmation.
