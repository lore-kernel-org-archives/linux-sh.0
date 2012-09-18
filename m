From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 18 Sep 2012 10:20:30 +0000
Subject: Re: [PATCH] dma: sudmac: add support for SUDMAC
Message-Id: <50584AEE.80406@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <503205B8.7060308@renesas.com>
In-Reply-To: <503205B8.7060308@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi-san,

2012/09/18 18:37, Guennadi Liakhovetski wrote:
> On Tue, 18 Sep 2012, Shimoda, Yoshihiro wrote:
> 
>> Hi Guennadi-san,
>>
>> 2012/09/18 16:35, Guennadi Liakhovetski wrote:
>>> Hi all
>>>
< snip >
>>>>> +static void sudmac_setup_xfer(struct shdma_chan *schan, int slave_id)
>>>>> +{
>>>>> +}
>>>
>>> Since you don't need this function, we could just make it optional in 
>>> shdma-base.c, but this can be done later too, nothing critical.
>>
>> Since the shdma-base.c has the following code, I think that the sudmac driver
>> needs this function:
>>
>> int shdma_init(struct device *dev, struct shdma_dev *sdev,
>> 		    int chan_num)
>> {
>> 	struct dma_device *dma_dev = &sdev->dma_dev;
>>
>> 	/*
>> 	 * Require all call-backs for now, they can trivially be made optional
>> 	 * later as required
>> 	 */
>> 	if (!sdev->ops ||
>> 	    !sdev->desc_size ||
>> 	    !sdev->ops->embedded_desc ||
>> 	    !sdev->ops->start_xfer ||
>> 	    !sdev->ops->setup_xfer ||
>> 	    !sdev->ops->set_slave ||
>> 	    !sdev->ops->desc_setup ||
>> 	    !sdev->ops->slave_addr ||
>> 	    !sdev->ops->channel_busy ||
>> 	    !sdev->ops->halt_channel ||
>> 	    !sdev->ops->desc_completed)
>> 		return -EINVAL;
> 
> Sure, I know that, that's why I've written "_make_ it optional," i.e., 
> remove the check above for ops->setup_xfer and only call it if available.

Thank you for the comment. I misunderstood your previous comment.
I will keep the sudmac_setup_xfer() at the moment.

Best regards,
Yoshihiro Shimoda

