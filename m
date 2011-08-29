From: Kevin Hilman <khilman@ti.com>
Date: Mon, 29 Aug 2011 18:23:34 +0000
Subject: Re: [PATCH 11/13] ARM: gpio: consolidate trivial gpiolib implementations
Message-Id: <87bov8t6u1.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110809080411.GA1831@n2100.arm.linux.org.uk>
	<E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1QqhM1-0003af-U5@rmk-PC.arm.linux.org.uk> (Russell King's
	message of "Tue, 09 Aug 2011 09:08:01 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Consolidate 24 trivial gpiolib implementions out of mach/gpio.h
> into asm/gpio.h.  This is basically the include of asm-generic/gpio.h
> and the definition of gpio_get_value, gpio_set_value, and gpio_cansleep
> as described in Documentation/gpio.txt
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For OMAP:

Tested-by: Kevin Hilman <khilman@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>

Also goes for patches 12 & 13 also.

Kevin
