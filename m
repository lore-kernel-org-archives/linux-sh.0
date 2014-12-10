From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Dec 2014 05:44:01 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <CANqRtoTs52ORCqY43OyPJ2ME7BBcQr3+RVGURjteFQAztDSZjg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
	<1415355104-2031-3-git-send-email-wsa@the-dreams.de>
	<CAMuHMdW7Y_OXWySwxDch82gcGv0fyFPQAxXwSFKQz-QbDN4cPQ@mail.gmail.com>
	<20141209140917.GA3386@katana>
In-Reply-To: <20141209140917.GA3386@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Hi Wolfram, Geert,

On Tue, Dec 9, 2014 at 11:09 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Dec 09, 2014 at 11:53:45AM +0100, Geert Uytterhoeven wrote:
>> Hi Wolfram,
>>
>> On Fri, Nov 7, 2014 at 11:11 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > --- a/drivers/i2c/busses/i2c-sh_mobile.c
>> > +++ b/drivers/i2c/busses/i2c-sh_mobile.c
>> > @@ -727,6 +886,21 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
>> >         if (ret)
>> >                 return ret;
>> >
>> > +       /* Init DMA */
>> > +       sg_init_table(&pd->sg, 1);
>> > +       pd->dma_direction = DMA_NONE;
>> > +       ret = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
>> > +                                            res->start + ICDR, &pd->dma_rx);
>> > +       if (ret = -EPROBE_DEFER)
>> > +               return ret;
>> > +
>> > +       ret = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
>> > +                                            res->start + ICDR, &pd->dma_tx);
>> > +       if (ret = -EPROBE_DEFER) {
>> > +               sh_mobile_i2c_release_dma(pd);
>> > +               return ret;
>> > +       }
>> > +
>>
>> If the DTS contains "dma" and "dma-names" properties, but CONFIG_RCAR_DMAC
>> is disabled, sh_mobile_i2c_request_dma_chan() returns -EPROBE_DEFER,
>> and the driver fails to initialize.
>>
>> If I remove the "dma" and "dma-names" properties, the driver does fall back
>> to PIO mode.
>>
>> I think this is a regression.
>
> The only solution I can think of is to not bail out here and retry again
> before every transfer? Doesn't sound elegant, though...

I think we have to request for each and every transfer. And fall back
to PIO as default in a transparent way. This because the number of DMA
channels are limited compared to number of potential consumers, so
request failure may happen at any time.

Thanks,

/ magnus
