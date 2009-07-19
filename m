From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 19 Jul 2009 19:38:05 +0000
Subject: Re: [PATCH] sh: Add support for multiple hwblk counters
Message-Id: <20090719193805.GB30569@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090717142455.14866.58859.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090717142455.14866.58859.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 17, 2009 at 11:24:55PM +0900, Magnus Damm wrote:
> Extend the SuperH hwblk code to support more than one counter.
> Contains ground work for the future Runtime PM implementation.

On Fri, Jul 17, 2009 at 11:43:38PM +0900, Magnus Damm wrote:
> This patch adds hwblk support for the sh7723 processor.

On Fri, Jul 17, 2009 at 11:52:05PM +0900, Magnus Damm wrote:
> Convert the r8a66597-hcd driver to dev_pm_ops. This makes
> the driver a good PM citizen and removes a warning printout.

On Fri, Jul 17, 2009 at 11:59:55PM +0900, Magnus Damm wrote:
> Convert the r8a66597-hcd driver to use the on_chip flag
> from platform data to enable on chip behaviour instead
> of relying on CONFIG_SUPERH_ON_CHIP_R8A66597 ugliness.
> 
> This makes the code cleaner and also allows us to support
> both external and internal r8a66597 with the same kernel.
> 
> It also makes the Kconfig part more future proof since
> we with this patch can add support for new processors
> with on-chip r8a66597 without modifying the Kconfig.

Applied, thanks.
