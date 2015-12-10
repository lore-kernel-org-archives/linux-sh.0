From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 10 Dec 2015 03:52:42 +0000
Subject: Re: [PATCH v2] dmaengine: usb-dmac: Document SoC specific compatibility strings
Message-Id: <20151210035547.GL1854@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1449035634-18761-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449035634-18761-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org

On Wed, Dec 02, 2015 at 02:53:54PM +0900, Simon Horman wrote:
> In general Renesas hardware is not documented to the extent where the
> relationship between IP blocks on different SoCs can be assumed although
> they may appear to operate the same way. Furthermore the documentation
> typically does not specify a version for individual IP blocks. For these
> reasons a convention of using the SoC name in place of a version and
> providing SoC-specific compatibility strings has been adopted.
> 
> Although not universally liked this convention is used in the bindings for
> most drivers for Renesas hardware. The purpose of this patch is to
> update the Renesas USB DMA Controller driver to follow this convention.

Applied, thanks


-- 
~Vinod
