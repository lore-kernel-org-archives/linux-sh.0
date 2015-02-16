From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 16 Feb 2015 17:29:26 +0000
Subject: Re: [PATCH v3 14/15] ARM: shmobile: bockw dts: Move Ethernet node to BSC
Message-Id: <1508858.7oRPD6kDLI@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1424105939-4910-15-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424105939-4910-15-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Monday 16 February 2015 17:58:58 Ulrich Hecht wrote:
> Move the Ethernet node to the new BSC node, as its connected to the
> Bus State Controller.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

But please see below for an additional comment.

> ---
>  arch/arm/boot/dts/r8a7778-bockw.dts | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts
> b/arch/arm/boot/dts/r8a7778-bockw.dts index 80e1465..97a1132 100644
> --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> @@ -46,17 +46,6 @@
>  		regulator-always-on;
>  	};
> 
> -	ethernet@18300000 {
> -		compatible = "smsc,lan9220", "smsc,lan9115";
> -		reg = <0x18300000 0x1000>;
> -
> -		phy-mode = "mii";
> -		interrupt-parent = <&irqpin>;
> -		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> -		reg-io-width = <4>;
> -		vddvario-supply = <&fixedregulator3v3>;
> -		vdd33a-supply = <&fixedregulator3v3>;
> -	};
> 
>  	sound {
>  		compatible = "simple-audio-card";
> @@ -76,6 +65,20 @@
>  	};
>  };
> 
> +&bsc {
> +	ethernet@18300000 {
> +		compatible = "smsc,lan89218", "smsc,lan9115";
> +		reg = <0x18300000 0x1000>;
> +
> +		phy-mode = "mii";
> +		interrupt-parent = <&irqpin>;
> +		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +		reg-io-width = <4>;
> +		vddvario-supply = <&fixedregulator3v3>;
> +		vdd33a-supply = <&fixedregulator3v3>;

Regulators are not documented in 
Documentation/devicetree/bindings/net/smsc911x.txt. Would you like to submit 
an additional patch to add them ? The tricky part is that different chip 
versions use different power supplies (at least the names vary, but I expect 
the number of supplies to vary as well, for instance the 9221 chip has 
vddvario, vdd33a and vdd33reg), but the driver currently hardcodes the 
supplies names.

> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";

-- 
Regards,

Laurent Pinchart

