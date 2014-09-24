From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 24 Sep 2014 13:01:30 +0000
Subject: Re: [PATCH v2 7/9] ARM: shmobile: lager: Enable DU device in DT
Message-Id: <5422C0AA.8060208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-8-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-8-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 9/24/2014 4:27 PM, Laurent Pinchart wrote:

> Specify the DU output topology, enable the DU device and configure the
> related pins.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts | 51 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 48 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 84dcafa..a036d88 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -144,6 +144,54 @@
>   		states = <3300000 1
>   			  1800000 0>;
>   	};
> +
> +	adv7123 {

    Again, ePAPR dictates using generic device node names, not just chip names.

> +		compatible = "adi,adv7123";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;

    Er, why? I don't see the "reg" props below...

> +
> +		ports {
> +			port@0 {
> +				adv7123_in: endpoint {
> +					remote-endpoint = <&du_out_rgb>;
> +				};
> +			};
> +			port@1 {
> +				adv7123_out: endpoint {
> +					remote-endpoint = <&vga_in>;
> +				};
> +			};
> +		};
> +	};

WBR, Sergei

