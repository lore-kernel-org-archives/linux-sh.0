From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Dec 2015 20:39:08 +0000
Subject: Re: [PATCH 1/9] i2c: document generic DT bindings for timing parameters
Message-Id: <20151203203908.GA29831@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
 <1449157899-6572-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449157899-6572-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, devicetree@vger.kernel.org

On Thu, Dec 03, 2015 at 04:51:31PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Also, sort the properties alphabetically and make indentation
> consistent. Wording largely taken from i2c-rk3x.txt, thanks guys!
> 
> Only "i2c-scl-internal-delay-ns" is new, the rest is used by two drivers
> already and was documented in their driver binding documentation.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: devicetree@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 31 ++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
> index 8a99150ac3a7fd..a00219f5ee0733 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
> @@ -29,12 +29,33 @@ Optional properties
>  These properties may not be supported by all drivers. However, if a driver
>  wants to support one of the below features, it should adapt the bindings below.
>  
> -- clock-frequency	- frequency of bus clock in Hz.
> -- wakeup-source		- device can be used as a wakeup source.
> +- clock-frequency
> +	frequency of bus clock in Hz.
>  
> -- interrupts		- interrupts used by the device.
> -- interrupt-names	- "irq" and "wakeup" names are recognized by I2C core,
> -			  other names are left to individual drivers.
> +- i2c-scl-falling-time-ns
> +	Number of nanoseconds the SCL signal takes to fall; t(f) in the I2C
> +	specification.
> +
> +- i2c-scl-internal-delay-ns
> +	Number of nanoseconds the IP core additionally needs to setup SCL.
> +
> +- i2c-scl-rising-time-ns
> +	Number of nanoseconds the SCL signal takes to rise; t(r) in the I2C
> +	specification.
> +
> +- i2c-sda-falling-time-ns
> +	Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
> +	specification.
> +
> +- interrupts
> +	interrupts used by the device.
> +
> +- interrupt-names
> +	"irq" and "wakeup" names are recognized by I2C core, other names are
> +	left to individual drivers.
> +
> +- wakeup-source
> +	device can be used as a wakeup source.
>  
>  Binding may contain optional "interrupts" property, describing interrupts
>  used by the device. I2C core will assign "irq" interrupt (or the very first
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
