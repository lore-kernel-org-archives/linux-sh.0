From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 May 2014 23:37:13 +0000
Subject: Re: [PATCH v3 4/7] ARM: lager: add vin1 node
Message-Id: <536C1529.3060107@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-5-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-5-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/14/2014 02:36 PM, Ben Dooks wrote:

> Add device-tree for vin1 (composite video in) on the
> lager board.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts | 38 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index a087421..6888866 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
[...]
> @@ -239,8 +244,41 @@
>   	status = "ok";
>   	pinctrl-0 = <&i2c2_pins>;
>   	pinctrl-names = "default";
> +
> +	adv7180: composite-in@0x20 {

    You're not using that label, as far as I could see.

> +		compatible = "adi,adv7180";
> +		reg = <0x20>;
> +		remote = <&vin1>;
> +
> +		port {
> +			adv7180_1: endpoint {

    So, you could use 'adv7180:' here instead...

> +				bus-width = <8>;
> +				remote-endpoint = <&vin1ep0>;
> +			};
> +		};
> +	};
> +

WBR, Sergei

