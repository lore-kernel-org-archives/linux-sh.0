From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 16 Apr 2013 10:56:31 +0000
Subject: Re: [PATCH v6 2/2] sudmac: add support for SUDMAC
Message-Id: <516D2E5F.8060802@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51664159.7080407@renesas.com>
In-Reply-To: <51664159.7080407@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

Thank you for the review.

(2013/04/16 2:09), Vinod Koul wrote:> On Thu, Apr 11, 2013 at 01:51:37PM +0900, Shimoda, Yoshihiro wrote:
>> --- /dev/null
>> +++ b/drivers/dma/sh/sudmac.c
>> @@ -0,0 +1,428 @@
>> +/*
>> + * Renesas SUDMAC support
>> + *
>> + * Copyright (C) 2012 Renesas Solutions Corp.
> 2013?

I will fix it.

>> +/* SUDMAC register */
>> +#define CH0CFG		0x00
>> +#define CH0BA		0x10
>> +#define CH0BBC		0x18
>> +#define CH0CA		0x20
>> +#define CH0CBC		0x28
>> +#define CH0DEN		0x30
>> +#define DSTSCLR		0x38
>> +#define DBUFCTRL	0x3C
>> +#define DINTCTRL	0x40
>> +#define DINTSTS		0x44
>> +#define DINTSTSCLR	0x48
>> +#define CH0SHCTRL	0x50
> Can you pls namespace these aptly

Yes, I will add namespace like "SUDMAC_CH0CFG".

>> +static void sudmac_setup_xfer(struct shdma_chan *schan, int slave_id)
>> +{
>> +}
> dead code?

No, the current shdma-base.c needs this call-back anyway.

>> +static int sudmac_set_slave(struct shdma_chan *schan, int slave_id, bool try)
>> +{
>> +	struct sudmac_chan *sc = to_chan(schan);
>> +	const struct sudmac_slave_config *cfg = sudmac_find_slave(sc, slave_id);
>> +
>> +	if (!cfg)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
> this doesnt seem to set anything...

The currenct shdma-base.c also needs this call-back.

>> +
>> +static void sudmac_dma_halt(struct sudmac_chan *sc)
>> +{
>> +	u32 dintctrl = sudmac_readl(sc, DINTCTRL);
>> +
>> +	sudmac_writel(sc, 0, CH0DEN + sc->offset);
>> +	sudmac_writel(sc, dintctrl & ~sc->dint_end_bit, DINTCTRL);
>> +	sudmac_writel(sc, sc->dint_end_bit, DINTSTSCLR);
>> +}
> how about making this inline

Does this comment mean I should write "static inline void sudmac_dma_halt..."?
If so, I will modify it.

>> +static void sudmac_halt(struct shdma_chan *schan)
>> +{
>> +	struct sudmac_chan *sc = to_chan(schan);
>> +
>> +	sudmac_dma_halt(sc);
>> +}
> could be inline

The sudmac_halt() is used as the call-back of shdma-base driver.
So, this function could not be inline, I think.

>> +
>> +static bool sudmac_chan_irq(struct shdma_chan *schan, int irq)
>> +{
>> +	struct sudmac_chan *sc = to_chan(schan);
>> +	u32 dintsts = sudmac_readl(sc, DINTSTS);
>> +
>> +	if (!(dintsts & sc->dint_end_bit))
>> +		return false;
>> +
>> +	/* DMA stop */
>> +	sudmac_dma_halt(sc);
>> +
>> +	return true;
>> +}
> why should irq stop the channel, sorry not following the logic here.

I imitated the shdma.c.
This function should do clearing the irq flag, disabling irq, and etc, I think.

>> +
>> +static size_t sudmac_get_partial(struct shdma_chan *schan,
>> +				 struct shdma_desc *sdesc)
>> +{
>> +	struct sudmac_chan *sc = to_chan(schan);
>> +	struct sudmac_desc *sd = to_desc(sdesc);
>> +	u32 cbc = sudmac_readl(sc, CH0CBC + sc->offset);
> user friendly variables pls

I will fix this variable name.

>> +static bool sudmac_desc_completed(struct shdma_chan *schan,
>> +				  struct shdma_desc *sdesc)
>> +{
>> +	struct sudmac_chan *sc = to_chan(schan);
>> +	struct sudmac_desc *sd = to_desc(sdesc);
>> +	u32 ca = sudmac_readl(sc, CH0CA + sc->offset);
> ditto

I got it.

>> +static dma_addr_t sudmac_slave_addr(struct shdma_chan *schan)
>> +{
>> +	/* SUDMAC doesn't need the address */
>> +	return 0;
>> +}
> why is that? This is a slave driver right?

This is because this DMAC knows slave address internally.
In other works, the DMAC doesn't have a register for slave address.

>> + * Copyright (C) 2012 Renesas Solutions Corp.
> 13 ?

Yes, I will fix it.

>> + *
>> + * based on include/linux/sh_dma.h:
>> + * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> No need to mention original copyright,

I got it.

Best regards,
Yoshihiro Shimoda
