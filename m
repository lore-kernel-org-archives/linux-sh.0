From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 Jan 2014 05:14:14 +0000
Subject: Re: [PATCH 0/4] r8a779[01]: Add new clocks to the device tree
Message-Id: <20140109051414.GI2132@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389082976-22254-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389082976-22254-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 07, 2014 at 09:22:52AM +0100, Laurent Pinchart wrote:
> Hello,
> 
> These four patches add the VIN and SATA clocks to the device tree. Not much
> else to be said, the changes should be safe and will be needed for VIN and
> SATA DT support.

Magnus, could you review these?

> Laurent Pinchart (4):
>   ARM: shmobile: r8a7790: Add VIN clocks to device tree
>   ARM: shmobile: r8a7791: Add VIN clocks to device tree
>   ARM: shmobile: r8a7790: Add SATA clocks to device tree
>   ARM: shmobile: r8a7791: Add SATA clocks to device tree
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 12 +++++++++---
>  arch/arm/boot/dts/r8a7791.dtsi | 11 ++++++++---
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
