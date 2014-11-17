From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Nov 2014 14:34:26 +0000
Subject: Re: [PATCH/RFC] gpio: em: Use dynamic allocation of GPIOs
Message-Id: <3857937.SYWZS9fGq6@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1416234632-16166-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416234632-16166-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Monday 17 November 2014 15:30:32 Geert Uytterhoeven wrote:
> Use dynamic allocation of GPIOs instead of looking at the gpio%u alias
> in DT.
> ---
>   - Is this correct? Not having to care about the alias would simplify the
>     to-be-written DT binding documentation.
>   - Completely untested.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 

This will obviously break any user that expects a particular gpio
number, in particular board files, but I guess also user space
that tries to access the gpios through sysfs.

If you don't have any of those, I guess it's correct.

	Arnd
