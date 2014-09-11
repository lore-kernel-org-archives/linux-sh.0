From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 11 Sep 2014 00:23:52 +0000
Subject: Re: [PATCH 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <5410EB98.9060203@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <54102904.6060703@renesas.com>
In-Reply-To: <54102904.6060703@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

(2014/09/11 8:56), Kuninori Morimoto wrote:
> 
> Hi Shimoda-san
> 
>> --- a/drivers/usb/renesas_usbhs/mod_gadget.c
>> +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
>> @@ -602,6 +602,9 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
>>  	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
>>  	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
>>
>> +	if (!uep || !uep->pipe)
>> +		return -EINVAL;
>> +
>>  	usbhsg_pipe_disable(uep);
>>  	usbhs_pipe_free(pipe);
> 
> If uep can be NULL,
> we need care about usbhsg_uep_to_pipe(uep) too.

Thank you for the point.
I will check the uep can be NULL or not.

> and, "uep->pipe" is same as "pipe" ?

Yes. I will use "pipe" instead of "uep->pipe".

Best regards,
Yoshihiro Shimoda

> Best regards
> ---
> Kuninori Morimoto
> 
