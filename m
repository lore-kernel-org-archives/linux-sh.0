From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 03 Feb 2015 21:43:25 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <54D140FD.4000000@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 01/27/2015 11:45 AM, Laurent Pinchart wrote:

> Enable the ethernet controller for the Alt board. Pin muxing entries are
> currently left out as r8a7794 pin control support isn't available yet.
> We thus rely on the boot loader to configure ethernet pins for now.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/boot/dts/r8a7794-alt.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
> index 0d848e605071..25bf434433b1 100644
> --- a/arch/arm/boot/dts/r8a7794-alt.dts
> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
> @@ -43,6 +43,19 @@
>   	status = "okay";
>   };
>
> +&ether {
> +	phy-handle = <&phy1>;
> +	renesas,ether-link-active-low;
> +	status = "okay";
> +
> +	phy1: ethernet-phy@1 {
> +		reg = <1>;
> +		interrupt-parent = <&irqc0>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;

    The hardware manual tells me the PHY uses IRQ8#, not IRQ0#.

[...]

WBR, Sergei

