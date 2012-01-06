From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 06 Jan 2012 04:00:25 +0000
Subject: Re: [RFC][PATCH 1/3] dmaengine: shdma: add .no_error_irq flag
Message-Id: <4F0671D9.8070209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0537F2.4080306@renesas.com>
In-Reply-To: <4F0537F2.4080306@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi-san,

Thank you very much for your review and suggestion.
I think that your suggestion is very good.

So, I could remove the no_error_irq flag using platform_get_irq_byname().
My modified patch is the following. And, if it is no problem,
I will submit it again:
-------
Subject: [PATCH] dmaengine: shdma: modify the DMAC Address Error registration

The USB-DMAC/SUDMAC don't have the interrupt of DMAC Address Error.
So, only when the resource has a name and it is "error_irq", the driver
calls request_irq() for DMAC Address Error.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/shdma.c |   70 ++++++++++++++++++++++++++++----------------------
 1 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index f427804..9916e54 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1233,10 +1233,10 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 	unsigned long irqflags = IRQF_DISABLED,
 		chan_flag[SH_DMAC_MAX_CHANNELS] = {};
-	int errirq, chan_irq[SH_DMAC_MAX_CHANNELS];
+	int errirq = 0, chan_irq[SH_DMAC_MAX_CHANNELS];
 	int err, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
 	struct sh_dmae_device *shdev;
-	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
+	struct resource *chan, *dmars, *errirq_res, *irq_res, *chanirq_res;

 	/* get platform data */
 	if (!pdata || !pdata->channel_num)
@@ -1261,8 +1261,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	 *    specify IORESOURCE_IRQ_SHAREABLE in their resources, they will be
 	 *    requested with the IRQF_SHARED flag
 	 */
-	errirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!chan || !errirq_res)
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!chan || !irq_res)
 		return -ENODEV;

 	if (!request_mem_region(chan->start, resource_size(chan), pdev->name)) {
@@ -1341,30 +1341,36 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	shdev->common.copy_align = LOG2_DEFAULT_XFER_SIZE;

 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
-	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
-
-	if (!chanirq_res)
-		chanirq_res = errirq_res;
-	else
-		irqres++;
-
-	if (chanirq_res = errirq_res ||
-	    (errirq_res->flags & IORESOURCE_BITS) = IORESOURCE_IRQ_SHAREABLE)
-		irqflags = IRQF_SHARED;
-
-	errirq = errirq_res->start;
-
-	err = request_irq(errirq, sh_dmae_err, irqflags,
-			  "DMAC Address Error", shdev);
-	if (err) {
-		dev_err(&pdev->dev,
-			"DMA failed requesting irq #%d, error %d\n",
-			errirq, err);
-		goto eirq_err;
+	errirq_res = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+						  "error_irq");
+	if (errirq_res) {
+		chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
+
+		if (!chanirq_res)
+			chanirq_res = errirq_res;
+		else
+			irqres++;
+
+		if (chanirq_res = errirq_res ||
+		    (errirq_res->flags & IORESOURCE_BITS) =
+		    IORESOURCE_IRQ_SHAREABLE)
+			irqflags = IRQF_SHARED;
+
+		errirq = errirq_res->start;
+
+		err = request_irq(errirq, sh_dmae_err, irqflags,
+				  "DMAC Address Error", shdev);
+		if (err) {
+			dev_err(&pdev->dev,
+				"DMA failed requesting irq #%d, error %d\n",
+				errirq, err);
+			goto eirq_err;
+		}
+	} else {
+		chanirq_res = irq_res;
 	}
-
 #else
-	chanirq_res = errirq_res;
+	chanirq_res = irq_res;
 #endif /* CONFIG_CPU_SH4 || CONFIG_ARCH_SHMOBILE */

 	if (chanirq_res->start = chanirq_res->end &&
@@ -1387,7 +1393,7 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 					break;
 				}

-				if ((errirq_res->flags & IORESOURCE_BITS) =
+				if ((irq_res->flags & IORESOURCE_BITS) =
 				    IORESOURCE_IRQ_SHAREABLE)
 					chan_flag[irq_cnt] = IRQF_SHARED;
 				else
@@ -1428,7 +1434,8 @@ chan_probe_err:
 	sh_dmae_chan_remove(shdev);

 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
-	free_irq(errirq, shdev);
+	if (errirq_res)
+		free_irq(errirq, shdev);
 eirq_err:
 #endif
 rst_err:
@@ -1461,12 +1468,13 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
 	struct resource *res;
-	int errirq = platform_get_irq(pdev, 0);
+	struct resource *errirq_res = platform_get_resource_byname(pdev,
+						IORESOURCE_IRQ, "error_irq");

 	dma_async_device_unregister(&shdev->common);

-	if (errirq > 0)
-		free_irq(errirq, shdev);
+	if (errirq_res)
+		free_irq(errirq_res->start, shdev);

 	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
-- 

Best regards,
Yoshihiro Shimoda

2012/01/05 18:01, Guennadi Liakhovetski wrote:
> Hello Shimoda-san
> 
> Thank you for your patch! Yes, it is good to have shdma handle different 
> DMAC types, e.g., those without an error IRQ. However, looking at your 
> patch I came up with an idea: I think, the resources themselves provide 
> enough information to decide, which interrupts are present and which are 
> not. How about using platform_get_irq_byname() and making the error 
> interrupt optional? This would eliminate the need for the .no_error_irq 
> flag. What do you think?
> 
> Thanks
> Guennadi
> 
> On Thu, 5 Jan 2012, Shimoda, Yoshihiro wrote:
> 
>> The USB-DMAC/SUDMAC don't have the interrupt of DMAC Address Error.
>> So, this patch adds the .no_error_irq flag.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  drivers/dma/shdma.c    |   50 ++++++++++++++++++++++++++---------------------
>>  include/linux/sh_dma.h |    1 +
>>  2 files changed, 29 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
>> index 81809c2..97f7d24 100644
>> --- a/drivers/dma/shdma.c
>> +++ b/drivers/dma/shdma.c
>> @@ -1151,7 +1151,7 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
>>  	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
>>  	unsigned long irqflags = IRQF_DISABLED,
>>  		chan_flag[SH_DMAC_MAX_CHANNELS] = {};
>> -	int errirq, chan_irq[SH_DMAC_MAX_CHANNELS];
>> +	int errirq = 0, chan_irq[SH_DMAC_MAX_CHANNELS];
>>  	int err, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
>>  	struct sh_dmae_device *shdev;
>>  	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
>> @@ -1259,26 +1259,31 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
>>  	shdev->common.copy_align = LOG2_DEFAULT_XFER_SIZE;
>>
>>  #if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
>> -	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
>> -
>> -	if (!chanirq_res)
>> +	if (pdata->no_error_irq) {
>>  		chanirq_res = errirq_res;
>> -	else
>> -		irqres++;
>> -
>> -	if (chanirq_res = errirq_res ||
>> -	    (errirq_res->flags & IORESOURCE_BITS) = IORESOURCE_IRQ_SHAREABLE)
>> -		irqflags = IRQF_SHARED;
>> -
>> -	errirq = errirq_res->start;
>> -
>> -	err = request_irq(errirq, sh_dmae_err, irqflags,
>> -			  "DMAC Address Error", shdev);
>> -	if (err) {
>> -		dev_err(&pdev->dev,
>> -			"DMA failed requesting irq #%d, error %d\n",
>> -			errirq, err);
>> -		goto eirq_err;
>> +	} else {
>> +		chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
>> +
>> +		if (!chanirq_res)
>> +			chanirq_res = errirq_res;
>> +		else
>> +			irqres++;
>> +
>> +		if (chanirq_res = errirq_res ||
>> +		    (errirq_res->flags & IORESOURCE_BITS) =
>> +		    IORESOURCE_IRQ_SHAREABLE)
>> +			irqflags = IRQF_SHARED;
>> +
>> +		errirq = errirq_res->start;
>> +
>> +		err = request_irq(errirq, sh_dmae_err, irqflags,
>> +				  "DMAC Address Error", shdev);
>> +		if (err) {
>> +			dev_err(&pdev->dev,
>> +				"DMA failed requesting irq #%d, error %d\n",
>> +				errirq, err);
>> +			goto eirq_err;
>> +		}
>>  	}
>>
>>  #else
>> @@ -1346,7 +1351,8 @@ chan_probe_err:
>>  	sh_dmae_chan_remove(shdev);
>>
>>  #if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
>> -	free_irq(errirq, shdev);
>> +	if (!pdata->no_error_irq)
>> +		free_irq(errirq, shdev);
>>  eirq_err:
>>  #endif
>>  rst_err:
>> @@ -1383,7 +1389,7 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
>>
>>  	dma_async_device_unregister(&shdev->common);
>>
>> -	if (errirq > 0)
>> +	if (!shdev->pdata->no_error_irq && errirq > 0)
>>  		free_irq(errirq, shdev);
>>
>>  	spin_lock_irq(&sh_dmae_lock);
>> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
>> index cb2dd11..b638f42 100644
>> --- a/include/linux/sh_dma.h
>> +++ b/include/linux/sh_dma.h
>> @@ -68,6 +68,7 @@ struct sh_dmae_pdata {
>>  	unsigned int dmaor_is_32bit:1;
>>  	unsigned int needs_tend_set:1;
>>  	unsigned int no_dmars:1;
>> +	unsigned int no_error_irq:1;
>>  };
>>
>>  /* DMA register */
>> -- 
>> 1.7.1
>>
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 


-- 
Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
EC No.
