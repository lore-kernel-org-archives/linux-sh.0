From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 02 Oct 2014 10:02:56 +0000
Subject: Re: [PATCH 2/3] arm: shmobile: koelsch: enable HS-USB
Message-Id: <542D22D0.4000209@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412237135-1668-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1412237135-1668-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412237135-1668-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org

On 10/2/2014 12:05 PM, Yoshihiro Shimoda wrote:

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7791-koelsch.dts |    5 +++++
>   1 file changed, 5 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 3f55c16..b3dac1a 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -495,3 +495,8 @@
>   		};
>   	};
>   };
> +
> +&hsusb {
> +	status = "okay";
> +	renesas,enable-gpio = <&gpio5 18 GPIO_ACTIVE_LOW>;

    I think it's GP5_31 on Koelsch instead, i.e. the ID output from MAX3355.

WBR, Sergei

