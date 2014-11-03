From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Nov 2014 08:58:48 +0000
Subject: Re: [RFC 1/3] i2c: sh_mobile: add DMA support
Message-Id: <CAMuHMdX1-ANQQhZkfKG67-TSKEUO6sFeiUMkkA323Ww4Cw9JrA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414752678-26078-1-git-send-email-wsa@the-dreams.de>
	<1414752678-26078-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1414752678-26078-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Wolfram,

On Fri, Oct 31, 2014 at 11:51 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c

> +static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
> +                                             enum dma_transfer_direction dir,
> +                                             dma_addr_t port_addr)
> +{
> +       dma_cap_mask_t mask;
> +       struct dma_chan *chan;
> +       struct dma_slave_config cfg;
> +       int ret;
> +
> +       dma_cap_zero(mask);
> +       dma_cap_set(DMA_SLAVE, mask);
> +
> +       chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> +                               (void *)0UL, dev, dir = DMA_MEM_TO_DEV ? "tx" : "rx");

Given you only support DT DMA configuration (you always pass (void *)0UL
as the channel ID), I think you can call dma_request_slave_channel(dev,
dir = DMA_MEM_TO_DEV ? "tx" : "rx") directly instead of using the
dma_request_slave_channel_compat() wrapper.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
