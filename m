From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 00:22:25 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: add USB3.0 device node on r8a7790
Message-Id: <20141027002225.GE25692@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414147307-4584-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414147307-4584-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, Oct 24, 2014 at 07:41:45PM +0900, Yoshihiro Shimoda wrote:
>  This series is based on Simon's renesas.git branch and
> renesas-devel-20141024-v3.18-rc1 tag. If we use the generic phy
> driver for R-Car Gen2 (drivers/phy/phy-rcar-gen2.c), we can use
> the USB3.0 on lager.

Thanks, I have queued these up.

> 
> Changes from v1:
>  - rebase the repository.
> 
> Yoshihiro Shimoda (2):
>   ARM: shmobile: r8a7790: add USB3.0 device node
>   ARM: shmobile: lager: enable USB3.0
> 
>  arch/arm/boot/dts/r8a7790-lager.dts |    6 ++++++
>  arch/arm/boot/dts/r8a7790.dtsi      |   10 ++++++++++
>  2 files changed, 16 insertions(+)
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
