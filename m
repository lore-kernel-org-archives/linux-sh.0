From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 24 Nov 2015 05:49:05 +0000
Subject: RE: [PATCH] dmaengine: usb-dmac: Document SoC specific bindings
Message-Id: <SG2PR06MB09198719427CB3F4FE532834D8060@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448331641-21758-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448331641-21758-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>, Vinod Koul <vinod.koul@intel.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Simon-san,

> From: Simon Horman [mailto:horms+renesas@verge.net.au]
> Sent: Tuesday, November 24, 2015 11:21 AM
> 
> In general Renesas hardware is not documented to the extent where the
> relationship between IP blocks on different SoCs can be assumed although
> they may appear to operate the same way. Furthermore the documentation
> typically does not specify a version for individual IP blocks. For these
> reasons a convention of using the SoC name in place of a version and
> providing SoC-specific compat strings has been adopted.
> 
> Although not universally liked this convention is used in the bindings for
> most drivers for Renesas hardware. The purpose of this patch is to
> update the Renesas USB DMA Controller driver to follow this convention.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thank you for the patch!

> ---
> * r8a7792 (R-Car V2H) is omitted as my reading of the documentation
>   is that Renesas USB-DMAC does not exist on that SoC

I agree with you.

> * r8a7795 (R-Car H2) is omitted as its unclear to me on the compatibility
>   of USB-DMAC that SoC

I think this is R-Car H3, not H2.
Since R-Car H3's USB-DMAC is compatible with other SoCs,
would you add the R-Car H3's compatible string, if possible?

Anyway,
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

