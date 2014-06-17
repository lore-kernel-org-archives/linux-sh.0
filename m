From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 17 Jun 2014 19:02:58 +0000
Subject: Re: [PATCH 9/9] ARM: lager: add vin1 node
Message-Id: <53A090E2.100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk> <1402862194-17743-10-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1402862194-17743-10-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, linux-media@vger.kernel.org
Cc: robert.jarzmik@free.fr, g.liakhovetski@gmx.de, magnus.damm@opensource.se, horms@verge.net.au, ian.molton@codethink.co.uk, william.towle@codethink.co.uk

Hello.

On 06/15/2014 11:56 PM, Ben Dooks wrote:

> Add device-tree for vin1 (composite video in) on the
> lager board.

    Several white space nits.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts | 38 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 4805c9f..8ecb294 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
[...]
> @@ -342,8 +347,41 @@
>   	status = "ok";
>   	pinctrl-0 = <&i2c2_pins>;
>   	pinctrl-names = "default";
> +
> +	composite-in@20 {
> +		compatible = "adi,adv7180";
> +		reg = <0x20>;
> +		remote = <&vin1>;
> +
> +		port {
> +			adv7180: endpoint {
> +				bus-width = <8>;
> +				remote-endpoint = <&vin1ep0>;
> +			};
> +		};
> +	};
> +

   Empty line not needed here...

>   };
>
>   &i2c3	{
>   	status = "ok";
>   };
> +
> +/* composite video input */
> +&vin1 {
> +	pinctrl-0 = <&vin1_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "ok";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		vin1ep0: endpoint {
> +			remote-endpoint = <&adv7180>;
> +			bus-width = <8>;
> +		};
> +	};
> +};
> +

    Here as well...

WBR, Sergei

