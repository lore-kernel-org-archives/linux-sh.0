From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Apr 2012 09:51:06 +0000
Subject: Re: [PATCH] usb: r8a66597-udc: add support for set_selfpowered
Message-Id: <4F85540A.2000602@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F62BD24.2060607@renesas.com>
In-Reply-To: <4F62BD24.2060607@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/04/11 18:35, Felipe Balbi wrote:
> On Fri, Mar 16, 2012 at 01:10:12PM +0900, Shimoda, Yoshihiro wrote:
>> The previous code always set to USB_DEVICE_SELF_POWERED in GET_STATUS.
>> So, this patch adds set_selfpowered().
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  drivers/usb/gadget/r8a66597-udc.c |   16 +++++++++++++++-
>>  drivers/usb/gadget/r8a66597-udc.h |    1 +
>>  2 files changed, 16 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
>> index c4401e7..683b3d2 100644
>> --- a/drivers/usb/gadget/r8a66597-udc.c
>> +++ b/drivers/usb/gadget/r8a66597-udc.c
>> @@ -1170,7 +1170,7 @@ __acquires(r8a66597->lock)
>>
>>  	switch (ctrl->bRequestType & USB_RECIP_MASK) {
>>  	case USB_RECIP_DEVICE:
>> -		status = 1 << USB_DEVICE_SELF_POWERED;
>> +		status = r8a66597->device_status;
>>  		break;
>>  	case USB_RECIP_INTERFACE:
>>  		status = 0;
>> @@ -1800,11 +1800,25 @@ static int r8a66597_pullup(struct usb_gadget *gadget, int is_on)
>>  	return 0;
>>  }
>>
>> +static int r8a66597_set_selfpowered(struct usb_gadget *gadget, int is_self)
>> +{
>> +	struct r8a66597 *r8a66597 = gadget_to_r8a66597(gadget);
>> +	unsigned long flags;
> 
> compile warning here. Did you even test this patch ???

I'm sorry, I should have checked it carefully.
I will fix and submit soon.

Best regards,
Yoshihiro Shimoda
