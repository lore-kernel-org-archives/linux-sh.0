From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 27 Feb 2014 12:20:19 +0000
Subject: Re: [RFC 1/4] ARM: dts: r8a7790-lager: Add VDD MPU regulator for DVFS
Message-Id: <530F2D83.3050008@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1393456190-7870-2-git-send-email-bcousson@baylibre.com>
In-Reply-To: <1393456190-7870-2-git-send-email-bcousson@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 26/02/14 23:09, Benoit Cousson wrote:
> The CA15 cluster is capable of voltage scaling. Add the regulator
> in the i2c3 node, to allow the generic CPUFreq driver to use it.
>
> Enable the i2c3 pin mux and the device node as well since the
> da9210 is connected to that bus.
>
> Note: Vmin is set to 0.8v to allow experimentation only.
> There is no guaranty that the CPUs will still work at this
> voltage.
>
> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 6e99eb2..5f77e3a 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -159,6 +159,11 @@
>   		renesas,groups = "qspi_ctrl", "qspi_data4";
>   		renesas,function = "qspi";
>   	};
> +
> +	i2c3_pins: i2c3 {
> +		renesas,groups = "i2c3";
> +		renesas,function = "i2c3";
> +	};
>   };

I thought i2c3 was a single function set of pins?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
