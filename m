From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 May 2012 03:05:55 +0000
Subject: Re: [PATCH 10/11] ARM: mach-shmobile: armadillo800eva: Add FSI-WM8978 support
Message-Id: <20120522030554.GB22483@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <874nr9aqxg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nr9aqxg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 21, 2012 at 07:30:06PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> +/*
> + * FIXME !!
> + *
> + * gpio_no_direction
> + *
> + * current gpio frame work doesn't have
> + * the method to control only pull up/down/free.
> + * this function should be replaced by correct gpio function
> + */
> +static void __init gpio_no_direction(u32 addr)
> +{
> +	__raw_writeb(0x00, addr);
> +}
> +
Now that we have 3 instances of the same routine, it's probably about
time to consolidate them in the mach-shmobile gpio.h. While we're at it,
it's probably worth renaming to gpio_direction_none(), so it matches the
other routines. In the future this will be replaced by the pinconf API.
