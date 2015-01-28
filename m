From: Simon Horman <horms@verge.net.au>
Date: Wed, 28 Jan 2015 06:48:19 +0000
Subject: Re: [PATCH 0/3] Renesas IPMMU DT nodes for R-Car H2, M2 and E2
Message-Id: <20150128064819.GB3581@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1422350005-20573-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422350005-20573-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 27, 2015 at 11:13:22AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch set adds DT nodes for the IPMMU instances found in the R-Car H2, M2
> and E2 SoCs. The nodes are currently all disabled until the first users show
> up.
> 
> The IPMMU DT bindings have been applied to the IOMMU tree and are scheduled to
> hit mainline in v3.20-rc1. This set depends on the DT bindings but has no
> compile-time or runtime dependency on any of the queued IPMMU patches.

Thanks Laurent,

I have queued these up for v3.21.

> 
> Laurent Pinchart (3):
>   ARM: shmobile: r8a7790: Add IPMMU DT nodes
>   ARM: shmobile: r8a7791: Add IPMMU DT nodes
>   ARM: shmobile: r8a7794: Add IPMMU DT nodes
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 51 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7791.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7794.dtsi | 50 +++++++++++++++++++++++++++++++++++
>  3 files changed, 161 insertions(+)
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
