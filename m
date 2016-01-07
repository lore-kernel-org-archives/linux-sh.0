From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Date: Thu, 07 Jan 2016 16:56:38 +0000
Subject: Re: [RFC v2 2/4] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <1452185798.2915.44.camel@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
	 <1452088285-6427-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452088285-6427-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>

Hi Wolfram,

On Mi, 2016-01-06 at 14:51 +0100, Wolfram Sang wrote:
[...]
> +Required properties:
> +- compatible: "i2c-demux-pinctrl"
> +- i2c-parent: List of phandles of I2C masters available for selection. The first
> +	      one will be used as default.
> +- i2c-bus-name: The name of this bus. Also needed as pinctrl-name for the I2C
> +		parents.
[...]
> +	i2chdmi: i2c@8 {
> +		compatible = "i2c-demux-pinctrl";
> +		i2c-parent = <&gpioi2c>, <&iic2>, <&i2c2>;
> +		i2c-bus-name = "i2c-hdmi";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
[...]
> +	gpioi2c: i2c@9 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "i2c-gpio";
[...]
> +&i2c2	{
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-names = "i2c-hdmi";
> +
> +	clock-frequency = <100000>;
> +};
[...]
> +&iic2	{
> +	pinctrl-0 = <&iic2_pins>;
> +	pinctrl-names = "i2c-hdmi";
> +
> +	clock-frequency = <100000>;
> +};
[...]

It seems that the demux-pinctrl driver reconfigures the pinctrl settings
for the parent devices. I would have expected to have alternative
pinctrl state on the demux node support switching the same external pins
between the different controllers. Wouldn't it be possible to have
pinctrl conflicts between &i2c2_pins and &iic2_pins otherwise?

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

