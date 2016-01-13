From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 13 Jan 2016 17:19:08 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: r8a7790: rework dts to use i2c demuxer
Message-Id: <5696870C.102@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
 <1452695369-29413-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452695369-29413-4-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

On 01/13/2016 05:29 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Create a seperate bus for HDMI related I2C slaves and assign it

    Separate.

> to a i2c-gpio master. It can be switched to the i2c-rcar or
> i2c-sh_mobile core at runtime.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> After the technical details of the underlying driver seem to be more or less
> sorted out, I would appreciate some discussion here about changing the Lager
> DTS e.g. if we really want GPIO to be the default?
>
>   arch/arm/boot/dts/r8a7790-lager.dts | 141 ++++++++++++++++++++++--------------
>   1 file changed, 88 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index c553abd711eeb3..d8f0ca8e094dad 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
[...]
> @@ -252,6 +254,79 @@
>   		#clock-cells = <0>;
>   		clock-frequency = <148500000>;
>   	};
> +
> +
> +	gpioi2c: i2c@9 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "i2c-gpio";

    I think this prop should go first.

> +		status = "disabled";

    In a board file? When do you intend to enable it?

> +		gpios = <&gpio5 6 GPIO_ACTIVE_HIGH /* sda */
> +			 &gpio5 5 GPIO_ACTIVE_HIGH /* scl */
> +			>;
> +		i2c-gpio,delay-us = <5>;
> +	};
[...]

MBR, Sergei

