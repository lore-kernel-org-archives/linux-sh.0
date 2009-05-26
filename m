From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 26 May 2009 05:00:25 +0000
Subject: Re: [PATCH] usb: r8a66597-hcd: use platform_data instead of
Message-Id: <4A1B7769.2000303@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A1B5D7C.6070205@renesas.com>
In-Reply-To: <4A1B5D7C.6070205@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

Paul Mundt wrote:
> On Tue, May 26, 2009 at 12:09:48PM +0900, Yoshihiro Shimoda wrote:
>> +struct r8a66597_platdata {
< snip >
>> +	/* set one = low level, set zero = falling edge */
>> +	unsigned	irq_sense:1;
>> +};
> 
> I would just get rid of irq_sense entirely. You can OR in
> IRQF_TRIGGER_LOW or IRQF_TRIGGER_FALLING against IORESOURCE_IRQ in the
> struct resource, so there is no need for reproducing this information
> elsewhere.

Thank you very much for your comment.
I did not notice it reproducing. I will fix this code.

Thanks,
Yoshihiro Shimoda
