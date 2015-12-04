From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Fri, 04 Dec 2015 08:34:28 +0000
Subject: Re: [PATCH 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <20151204083428.GC1593@lahna.fi.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
 <1449157899-6572-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1449157899-6572-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Thu, Dec 03, 2015 at 04:51:32PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Inspired from the i2c-rk3x driver (thanks guys!) but refactored and
> extended. See built-in docs for further information.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-core.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c.h    | 22 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index ba8eb087f22465..5c269dd51b2de7 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1438,6 +1438,56 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
>  	}
>  }
>  
> +/**
> + * of_i2c_parse_timings - get I2C related timing parameters from DT
> + * @node: The DT node to scan for I2C timing properties
> + * @t: the i2c_timings struct to be filled with values
> + * @use_defaults: bool to use sane defaults derived from the I2C specification
> + * 		  when properties are not found, otherwise use 0
> + *
> + * Scan the node pointer for the generic I2C DT properties describing timing
> + * parameters for the signal and fill the given struct with the results. If a
> + * property was not found and use_defaults was true, then maximum timings are
> + * assumed which are derived from the I2C specification. If use_defaults is not
> + * used, the result will be 0, so drivers can apply their own defaults later.
> + * The latter is mainly intended for avoiding regressions of existing drivers
> + * which want to switch to this function. New drivers almost always should use
> + * the defaults.
> + */
> +void of_i2c_parse_timings(struct device_node *node, struct i2c_timings *t, bool use_defaults)
> +{
> +	memset(t, 0, sizeof(*t));
> +
> +	if (of_property_read_u32(node, "clock-frequency", &t->bus_freq_hz) && use_defaults)
> +		t->bus_freq_hz = 100000;

Why not create device_i2c_parse_timings() instead and use unified device
properties API?
