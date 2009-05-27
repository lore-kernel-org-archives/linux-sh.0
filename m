From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 27 May 2009 00:25:45 +0000
Subject: Re: [PATCH v2] usb: r8a66597-hcd: use platform_data instead of
Message-Id: <4A1C8889.7000300@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A1BB552.3020909@renesas.com>
In-Reply-To: <4A1BB552.3020909@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

Paul Mundt wrote:
> On Tue, May 26, 2009 at 06:24:34PM +0900, Yoshihiro Shimoda wrote:
>> CPU/board specific parameters (PLL clock, vif etc...) can be set
>> by platform_data instead of module_param.
>>
>> v2: remove irq_sense member in platform_data because it can OR in
>>     IRQF_TRIGGER_LOW or IRQF_TRIGGER_FALLING against IORESOURCE_IRQ in
>>     the struct resource.
>>
>> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> 
> Looks better!
> 
> Reviewed-by: Paul Mundt <lethal@linux-sh.org>
> 

Thank you very much your review and Reviewed-by.

Thanks,
Yoshihiro Shimoda
