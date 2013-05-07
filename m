From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 07 May 2013 15:09:53 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
Message-Id: <51891941.7040202@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1367908563-20293-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1367908563-20293-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07-05-2013 18:51, Laurent Pinchart wrote:

>>> the USB OVC pins

>>      This is too vague -- I would have been more specific: USB_OVCn pins.

>>> are optional  alternate options

>>      "Optional options" sound somewhat tautological. :-)

>>> for USB over-current
>>> detection when using a 3.3V USB interface. As they're not mandatory,
>>> don't group them with the USB PENC pins.

>>      I'd mention a false pin conflict with HSPI on Marzen that grouping
>> the pins ensued.

> What about

> The USB_OVCn pins alternate options for USB over-current detection when using

    You missed "are" here.

> a 3.3V USB interface. As they're not mandatory they can be used independently
> of the USB PENC pins. Don't group the USB_OVCn and PENC pins to avoid
> conflicts when the USB_OVCn pins are used by another function.

    Thanks, that's better.

>>> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> ---

>>>    drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 45 +++++++++++++++++++++++-------
>>>    1 file changed, 36 insertions(+), 9 deletions(-)

>>> Simon, this is a v3.10 fix, could you apply it upon Sergei's ack ?

>>> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
>>> b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index d6056ed..ddc2b2e 100644
>>> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
>>> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
>>> @@ -2392,27 +2392,48 @@ static const unsigned int sdhi3_wp_mux[] = {
>>>
>>>    };
>>>    /* - USB0
>>>    ------------------------------------------------------------------- */
>>>    static const unsigned int usb0_pins[] = {
>>>
>>> -	/* OVC */
>>> -	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 26),
>>> +	/* PENC */
>>
>>       PENC0.

> It's the PENC pin for the USB0 function, so the comments refer to PENC, not
> PENC0. Same for the other pins below.

    No, the other pins are not the same: there's OVCn and USB_OVCn pins, 
you're mixing them up in your other comments.

WBR, Sergei

