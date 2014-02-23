From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 23 Feb 2014 19:26:01 +0000
Subject: Re: [RFC] ARM: shmobile: koelsch: activate i2c6 bus
Message-Id: <1944985.uR4APBXffS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1393159437-14456-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1393159437-14456-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Sunday 23 February 2014 13:43:57 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
> 
> I used this patch to test my IIC(B) enablement patches. With i2ctools,  I
> could scan this bus and read registers from the connected pmic. Actually, I
> don't think we should expose this bus unless really needed, but maybe you
> think different?

The I2C6 bus signals are routed to an extension connector as well as to the 
DA9063 PMIC and DA9210 sub-PMIC. There's no urgent need to enable it now as we 
don't instantiate support the PMIC and sub-PMIC at the moment. However, as 
we'll have to enable it anyway,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Is anyone working on PMIC support for the Koelsch board ? The DA9063 and 
DA9210 have drivers in mainline. They might not support all the features we 
need, but limited support shouldn't be difficult.

>  arch/arm/boot/dts/r8a7791-koelsch.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> b/arch/arm/boot/dts/r8a7791-koelsch.dts index e6ca0e0..4557f8e 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -122,6 +122,11 @@
>  	};
>  };
> 
> +&i2c6 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +};
> +
>  &pfc {
>  	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
>  	pinctrl-names = "default";

-- 
Regards,

Laurent Pinchart

