From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Dec 2014 13:44:58 +0000
Subject: Re: [RFC 2/2] i2c: sh_mobile: rework deferred probing
Message-Id: <CAMuHMdX2u4J2Dqb2ww23F4ED2QFWu4Ev2tF9Nr6o0PXRdpxSDA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
	<1418217709-26392-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418217709-26392-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Wolfram,

On Wed, Dec 10, 2014 at 2:21 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> DMA is opt-in for this driver. So, we can't use deferred probing in
> probe, because our driver would get endlessly deferred if DMA support is
> compiled in but only the DMA driver is missing. Because we can't know
> when the DMA driver might show up, we always try again when a DMA
> transfer would be possible. The downside is that there is more overhead
> for setting up every DMA transfer.

... for setting up every PIO transfer?

Once DMA is available, it's just one extra variable check.

> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-sh_mobile.c | 98 +++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 636f2297143a..ea7b99212fa6 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -144,6 +144,7 @@ struct sh_mobile_i2c_data {
>         int sr;
>         bool send_stop;
>
> +       struct resource *res;

I thinkk you can just store dma_addr_t port_addr here.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
