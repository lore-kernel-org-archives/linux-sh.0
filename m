From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 22 Jun 2015 22:40:18 +0000
Subject: Re: [PATCH 08/08] ARM: shmobile: Remove CMT renesas,channels-mask from DTS
Message-Id: <8019375.XSP9R0ZLbm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple> <20150621081033.10187.38630.sendpatchset@little-apple>
In-Reply-To: <20150621081033.10187.38630.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, tglx@linutronix.de

Hi Magnus,

Thank you for the patch.

On Sunday 21 June 2015 17:10:33 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Update the DTS to remove the now deprecated "renesas,channels-mask"
> property.
> 
> The channel information is now kept in the device driver and can easily
> be determined based on the compat string.

Unless I've missed something (which is entirely possibly given the late hour), 
the channel mask is only stored in the driver for the Gen2 CMT instances.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  arch/arm/boot/dts/r8a73a4.dtsi |    3 ---
>  arch/arm/boot/dts/r8a7740.dtsi |    3 ---
>  arch/arm/boot/dts/r8a7790.dtsi |    6 ------
>  arch/arm/boot/dts/r8a7791.dtsi |    6 ------
>  arch/arm/boot/dts/r8a7793.dtsi |    6 ------
>  arch/arm/boot/dts/r8a7794.dtsi |    6 ------
>  arch/arm/boot/dts/sh73a0.dtsi  |    3 ---
>  7 files changed, 33 deletions(-)

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
