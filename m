From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 16 Nov 2015 03:51:52 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document SoC specific bindings
Message-Id: <20151116035533.GC25173@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

On Thu, Nov 12, 2015 at 10:53:59AM +0900, Simon Horman wrote:
> In general Renesas hardware is not documented to the extent where the
> relationship between IP blocks on different SoCs can be assumed although
> they may appear to operate the same way. Furthermore the documentation
> typically does not specify a version for individual IP blocks. For these
> reasons a convention of using the SoC name in place of a version and
> providing SoC-specific compat strings has been adopted.
> 
> Although not universally liked this convention is used in the bindings for
> most drivers for Renesas hardware. The purpose of this patch is to
> update the Renesas R-Car DMA Controller driver to follow this convention.

Applied, thanks

-- 
~Vinod
