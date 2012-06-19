From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 19 Jun 2012 04:49:47 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: kzm9g: enable MicroSD
Message-Id: <4FE004EB.2080002@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <877gv4t4xk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gv4t4xk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, morimoto-san.

(2012/06/19 13:18), Kuninori Morimoto wrote:

>> genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 802
>> mmc0: new high speed SDHC card at address e624
>> mmcblk0: mmc0:e624 SU04G 3.69 GiB
>>   mmcblk0: p1 p2
>> sh_mobile_sdhi: probe of sh_mobile_sdhi.2 failed with error -22
>>    ...
>>
>> Using debugger I found
>>    drivers/mmc/host/sh_mobile_sdhi.c: 168
>> 	ret = tmio_mmc_host_probe(&host, pdev, mmc_data);
>> returns -22.
>
> Oops. yes indeed.
> Sorry, I didn't explain about this.
> It depends on latest mmc ML branch too.
> I'm not sure detail of mmc branch status,
> but is below patch solve your issue ?

Yes. It works fine with this patch and
   mmc: tmio: Don't access hardware registers after stopping clocks

>
> ------------------------------------------
> diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
> index f13e38d..f303cbc 100644
> --- a/drivers/mmc/core/cd-gpio.c
> +++ b/drivers/mmc/core/cd-gpio.c
> @@ -50,7 +50,7 @@ int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio)
>   		goto egpioreq;
>
>   	ret = request_threaded_irq(irq, NULL, mmc_cd_gpio_irqt,
> -				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>   				   cd->label, host);
>   	if (ret<  0)
>   		goto eirqreq;
> ------------------------------------------

