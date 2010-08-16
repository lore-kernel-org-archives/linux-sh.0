From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Aug 2010 04:23:28 +0000
Subject: Re: [PATCH][RFC] ARM: mach-shmobile: AP4EVB: use gpio-leds for leds.
Message-Id: <20100816042328.GA8817@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1281815121-3724-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1281815121-3724-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Aug 14, 2010 at 09:45:21PM +0200, Arnd Hannemann wrote:
> This allows control of the leds on the AP4EVB board by kernel events (triggers)
> like mmc0/mmc1. In userland, the leds won't be available anymore over
> /sys/class/gpio but via /sys/class/leds.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

A few minor nits. For starters, your editor has added trailing whitespace
all over the place, so please run future patches through checkpatch for
basic sanity checks first.

> +static struct gpio_led ap4evb_leds[] = { 
[snip]
> +};
> +
> +static struct gpio_led_platform_data ap4evb_leds_pdata = {
> +	.num_leds = ARRAY_SIZE(ap4evb_leds),
> +	.leds = &ap4evb_leds,
> +};
> +
Here you obviously want .leds = ap4evb_leds. Has this been tested?

I'll apply it with those fixes, since it's a reasonable direction to go.
