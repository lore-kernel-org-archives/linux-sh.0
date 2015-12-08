From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 08 Dec 2015 10:54:45 +0000
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <1449572085.30729.28.camel@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
	 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Tue, 2015-12-08 at 10:37 +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Inspired from the i2c-rk3x driver (thanks guys!) but refactored and
> extended. See built-in docs for further information.

One style comment.

> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core.c | 47
> +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h    | 18 ++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index ba8eb087f22465..e94d2ca2aab4aa 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -53,6 +53,7 @@
>  #include <linux/jump_label.h>
>  #include <asm/uaccess.h>
>  #include <linux/err.h>
> +#include <linux/property.h>
>  
>  #include "i2c-core.h"
>  
> @@ -1438,6 +1439,52 @@ static void of_i2c_register_devices(struct
> i2c_adapter *adap)
>  	}
>  }
>  
> +/**
> + * i2c_parse_fw_timings - get I2C related timing parameters from
> firmware
> + * @dev: The device to scan for I2C timing properties
> + * @t: the i2c_timings struct to be filled with values
> + * @use_defaults: bool to use sane defaults derived from the I2C
> specification
> + * 		  when properties are not found, otherwise use 0
> + *
> + * Scan the device for the generic I2C properties describing timing
> parameters
> + * for the signal and fill the given struct with the results. If a
> property was
> + * not found and use_defaults was true, then maximum timings are
> assumed which
> + * are derived from the I2C specification. If use_defaults is not
> used, the
> + * results will be 0, so drivers can apply their own defaults later.
> The latter
> + * is mainly intended for avoiding regressions of existing drivers
> which want
> + * to switch to this function. New drivers almost always should use
> the defaults.
> + */
> +
> +void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t,
> bool use_defaults)
> +{
> +	memset(t, 0, sizeof(*t));
> +
> +	if (device_property_read_u32(dev, "clock-frequency", &t-
> >bus_freq_hz) && use_defaults)
> +		t->bus_freq_hz = 100000;
> +
> +	if (device_property_read_u32(dev, "i2c-scl-rising-time-ns",
> &t->scl_rise_ns) && use_defaults) {
> +		if (t->bus_freq_hz <= 100000)
> +			t->scl_rise_ns = 1000;
> +		else if (t->bus_freq_hz <= 400000)
> +			t->scl_rise_ns = 300;
> +		else
> +			t->scl_rise_ns = 120;
> +	}
> +
> +	if (device_property_read_u32(dev, "i2c-scl-falling-time-ns", 
> &t->scl_fall_ns) && use_defaults) {
> +		if (t->bus_freq_hz <= 400000)
> +			t->scl_fall_ns = 300;
> +		else
> +			t->scl_fall_ns = 120;
> +	}
> +
> +	device_property_read_u32(dev, "i2c-scl-internal-delay-ns",
> &t->scl_int_delay_ns);
> +
> +	if (device_property_read_u32(dev, "i2c-sda-falling-time-ns", 
> &t->sda_fall_ns) && use_defaults)
> +		t->sda_fall_ns = t->scl_fall_ns;

Too many && use_defaults. What about

memset(t, 0, sizeof(*t));

device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t-
>scl_int_delay_ns);

if (!use_defaults)
 return;

...


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

