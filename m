From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Nov 2013 08:30:34 +0000
Subject: Re: [PATCH v2] gpio: Renesas RZ GPIO driver V2
Message-Id: <CACRpkdbK0HV5WCtah7aw4suz=CjaBVOZR0vv=YSkXQqmjr_U5g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131113233411.565.32282.sendpatchset@w520>
In-Reply-To: <20131113233411.565.32282.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Thu, Nov 14, 2013 at 12:34 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> This patch adds a GPIO driver for the RZ series of SoCs from
> Renesas. The V2 of the driver requires DT to be used.
>
> The hardware allows control of GPIOs in blocks of up to 16 pins.
> Interrupts are not included in this hardware block, if interrupts
> are needed then the PFC needs to be configured to a IRQ pin function
> which is handled by the GIC hardware.
>
> Tested with yet-to-be-posted DT devices on r7s72100 and Genmai using
> LEDs, DIP switches and I2C bitbang.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>  Changes since V1:
>  - Drop platform data interface as suggested by Linus Walleij, thanks!
>  - Various changes suggested by Laurent Pinchart (except !!), thanks!

This looks all right to me, but I'm waiting for you and Laurent
to hash out the final details (v3?)

Yours,
Linus Walleij
