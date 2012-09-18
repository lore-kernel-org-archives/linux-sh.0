From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 18 Sep 2012 09:26:53 +0000
Subject: Re: [PATCH] dma: sudmac: add support for SUDMAC
Message-Id: <50583E5D.1030507@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <503205B8.7060308@renesas.com>
In-Reply-To: <503205B8.7060308@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi-san,

2012/09/18 16:35, Guennadi Liakhovetski wrote:
> Hi all
> 
> On Tue, 18 Sep 2012, Simon Horman wrote:
> 
>> On Mon, Aug 20, 2012 at 06:39:04PM +0900, Shimoda, Yoshihiro wrote:
>>> Some Renesas USB modules have SUDMAC. This patch supports it using
>>> the shdma-base driver.
>>
>> Hi Shimoda-san, Hi all,
>>
>> I would like to enquire about the status of this patch.
>> Is it still awaiting review?
> 
> I don't think my review is compulsory, and I don't have too many things to 
> complain about here, anyway:-) Just a couple of minor points / questions, 
> maybe, without going into SUDMAC operation details:

Thank you for the review!

< snip >
>>> +static void sudmac_setup_xfer(struct shdma_chan *schan, int slave_id)
>>> +{
>>> +}
> 
> Since you don't need this function, we could just make it optional in 
> shdma-base.c, but this can be done later too, nothing critical.

Since the shdma-base.c has the following code, I think that the sudmac driver
needs this function:

int shdma_init(struct device *dev, struct shdma_dev *sdev,
		    int chan_num)
{
	struct dma_device *dma_dev = &sdev->dma_dev;

	/*
	 * Require all call-backs for now, they can trivially be made optional
	 * later as required
	 */
	if (!sdev->ops ||
	    !sdev->desc_size ||
	    !sdev->ops->embedded_desc ||
	    !sdev->ops->start_xfer ||
	    !sdev->ops->setup_xfer ||
	    !sdev->ops->set_slave ||
	    !sdev->ops->desc_setup ||
	    !sdev->ops->slave_addr ||
	    !sdev->ops->channel_busy ||
	    !sdev->ops->halt_channel ||
	    !sdev->ops->desc_completed)
		return -EINVAL;


< snip >
>>> +const struct dev_pm_ops sudmac_pm = {
>>> +	.suspend		= sudmac_suspend,
>>> +	.resume			= sudmac_resume,
>>> +	.runtime_suspend	= sudmac_runtime_suspend,
>>> +	.runtime_resume		= sudmac_runtime_resume,
>>> +};
> 
> All the above (runtime-)PM callbacks: are they really all needed? I think 
> some of them can be dropped with no functionality reduction.
> 

At the moment, those functions don't have any code. So, I will remove them.

< snip >
>>> +static int __devinit sudmac_probe(struct platform_device *pdev)
>>> +{
>>> +	struct sudmac_pdata *pdata = pdev->dev.platform_data;
>>> +	int err, i;
>>> +	struct sudmac_device *su_dev;
>>> +	struct dma_device *dma_dev;
>>> +	struct resource *chan, *irq_res;
>>> +
>>> +	/* get platform data */
>>> +	if (!pdata)
>>> +		return -ENODEV;
>>> +
>>> +	chan = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>> +	if (!chan || !irq_res)
>>> +		return -ENODEV;
>>> +
>>> +	err = -ENOMEM;
>>> +	su_dev = kzalloc(sizeof(struct sudmac_device), GFP_KERNEL);
>>> +	if (!su_dev) {
>>> +		dev_err(&pdev->dev, "Not enough memory\n");
>>> +		goto ealloc;
>>> +	}
>>> +
>>> +	dma_dev = &su_dev->shdma_dev.dma_dev;
>>> +
>>> +	su_dev->chan_reg = ioremap(chan->start, resource_size(chan));
> 
> Recently it has become popular to use device-managed resource 
> allocation:-) Indeed, it is rather convenient, so, you could consider 
> using devm_kzalloc(), devm_request_irq(), devm_request_and_ioremap(), but 
> this too would just be a minor improvement, IMHO.

I understood it. I will modidy the code.

< snip >
>>> +/* SUDMAC register */
>>> +#define CH0CFG		0x00
>>> +#define CH0BA		0x10
>>> +#define CH0BBC		0x18
>>> +#define CH0CA		0x20
>>> +#define CH0CBC		0x28
>>> +#define CH0DEN		0x30
>>> +#define DSTSCLR		0x38
>>> +#define DBUFCTRL	0x3C
>>> +#define DINTCTRL	0x40
>>> +#define DINTSTS		0x44
>>> +#define DINTSTSCLR	0x48
>>> +#define CH0SHCTRL	0x50
>>> +
>>> +/* Definitions for the SUDMAC */
>>> +#define SENDBUFM	0x1000 /* b12: Transmit Buffer Mode */
>>> +#define RCVENDM		0x0100 /* b8: Receive Data Transfer End Mode */
>>> +#define LBA_WAIT	0x0030 /* b5-4: Local Bus Access Wait */
>>> +#define DEN		0x0001 /* b0: DMA Transfer Enable */
>>> +#define CH1ENDE		0x0002 /* b1: Ch1 DMA Transfer End Int Enable */
>>> +#define CH0ENDE		0x0001 /* b0: Ch0 DMA Transfer End Int Enable */
> 
> Do we really need register addresses in a public header under 
> include/linux/? If not - I'd really rather hide them in the private 
> header and only keep the absolute minimum here.

We need some definitions for the platform_data. But we don't need register addresses.
I will modify the public header.

Best regards,
Yoshihiro Shimoda

> Thanks
> Guennadi
> 
>>> +
>>> +#endif
>>> -- 
>>> 1.7.1
>>> --
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

