From: David Brownell <david-b@pacbell.net>
Date: Fri, 26 Dec 2008 19:10:13 +0000
Subject: Re: [PATCH 00/04] sh: gpio update
Message-Id: <200812261110.13717.david-b@pacbell.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20081225091701.7670.10659.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081225091701.7670.10659.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 25 December 2008, Magnus Damm wrote:
> sh: gpio update
> 
> [PATCH 01/04] sh: make gpio_get/set_value() O(1)

More than doubling the speed.  Good.


> [PATCH 02/04] sh: lockless gpio_get_value()

Lockless register reads ... generally safe.  :)
I'll trust you refactored this right.


> [PATCH 03/04] sh: lockless gpio_set_value()

I'm not clear how "lockless" here could be safe though;
these all use software for register read/modify/write,
which means an IRQ could arrive in the middle and, by
reentering that code, invalidate what's being written.


> [PATCH 04/04] sh: use gpiolib
> 
> This patchset improves the performance of the SuperH gpio
> implementation and converts it to make use of gpiolib.
> 
> The patches have been tested on Migo-R with the spi_gpio driver
> together with mmc_spi. Bitbanging mmc performance is improved
> from about 11 KBytes/s to 40 KBytes/s.

Sounds good.  The mmc_spi code won't be what I'd call fast,
especially when bitbanging, so every little bit helps.

If those ganged GPIO calls ever happen, MMC would seem to
be a decent candidate to use them:  get a 4x improvement in
raw data rate by implementing the native protocol not the
SPI version.

- Dave


> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  arch/sh/Kconfig            |    7 
>  arch/sh/boards/Kconfig     |    4 
>  arch/sh/include/asm/gpio.h |   70 ++++---
>  arch/sh/kernel/Makefile_32 |    2 
>  arch/sh/kernel/Makefile_64 |    2 
>  arch/sh/kernel/gpio.c      |  386 ++++++++++++++++++++++++++------------------
>  drivers/serial/sh-sci.h    |    2 
>  7 files changed, 288 insertions(+), 185 deletions(-)
> 
> 


