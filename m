From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Apr 2013 17:44:33 +0000
Subject: Re: [PATCH v3 7/9] rcar-phy: add platform data
Message-Id: <5165A501.8000808@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304100237.50334.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100237.50334.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/10/2013 09:16 PM, Felipe Balbi wrote:

>>>> Currently the driver hard-codes USBPCTRL0 register to 0.  It is wrong since this
>>>> register contains board-specific USB ports configuration and so its value should
>>>> be somehow passed via the platform data.  Add <linux/usb/rcar-phy.h> file with
>>>> the USBPCTRL0 bit #define's and 'struct rcar_phy_platform_data' containing the
>>>> value to be set by the driver to that register.
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>>>> ---
>>>> Changes since version 2:
>>>> - added #include <linux/types.h>;
>>>> - added ACKs from Simon Horman and Kuninori Morimoto.
>>>>   include/linux/usb/rcar-phy.h |   40 ++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 40 insertions(+)
>>>> Index: renesas/include/linux/usb/rcar-phy.h
>>>> =================================>>>> --- /dev/null
>>>> +++ renesas/include/linux/usb/rcar-phy.h
>>>> @@ -0,0 +1,40 @@
>>>> +/*
>>>> + * Copyright (C) 2013 Renesas Solutions Corp.
>>>> + * Copyright (C) 2013 Cogent Embedded, Inc.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#ifndef __RCAR_PHY_H
>>>> +#define __RCAR_PHY_H
>>>> +
>>>> +#include <linux/bitops.h>
>>>> +#include <linux/types.h>
>>>> +
>>>> +/* USBPCTRL0 register bits */
>>>> +#define USBPCTRL0_OVC2	BIT(10)	/* Switches the OVC input pin for port 2: */
>>>> +				/* 1: USB_OVC2, 0: OVC2			*/
>>>> +#define USBPCTRL0_OVC1_VBUS1 BIT(9) /* Switches the OVC input pin for port 1: */
>>>> +				/* 1: USB_OVC1, 0: OVC1/VBUS1		*/
>>>> +#define USBPCTRL0_OVC0	BIT(8)	/* Switches the OVC input pin for port 0: */
>>>> +				/* 1: USB_OVC0 pin, 0: OVC0		*/
>>>> +#define USBPCTRL0_OVC2_ACT BIT(6) /* Host mode: OVC2 polarity:		*/
>>>> +				/* 1: active-high, 0: active-low	*/
>>>> +				/* Function mode: be sure to set to 1	*/
>>>> +#define USBPCTRL0_PENC	BIT(4)	/* Function mode: output level of PENC1 pin: */
>>>> +				/* 1: high, 0: low			*/
>>>> +#define USBPCTRL0_OVC0_ACT BIT(3) /* Host mode: OVC0 polarity:		*/
>>>> +				/* 1: active-high, 0: active-low	*/
>>>> +#define USBPCTRL0_OVC1_ACT BIT(1) /* Host mode: OVC1 polarity:		*/
>>>> +				/* 1: active-high, 0: active-low	*/
>>>> +				/* Function mode: be sure to set to 1	*/
>>>> +#define USBPCTRL0_PORT1	BIT(0)	/* Selects port 1 mode:			*/
>>>> +				/* 1: function, 0: host			*/
>>>> +
>>>> +struct rcar_phy_platform_data {
>>>> +	u32 usbpctrl0;		/* USBPCTRL0 register value */
>>>> +};
>>> looks really wrong to me to pass register contents via pdata. You should
>>> pass flags which would aid the driver into figuring out how to program
>>> that register.
>>     That was my first thought (and implementation) but this didn't
>> look good either (and even worse with the device tree approach) as we
>> couldn't come up with the clear names for the bitfields. Also, not
>> all these bits are present in R8A7778 support for which I'm adding in
>> the later patchset.
>>     Besides, IMO this little differs from having a flags field with
>> the flags bits #define'd beforehand. Or did you mean that I should
>> have surely used *bool* bitfields?
> How about:

     Er, I was asking you about the platform data only, not the DT 
representation yet. :-)

>
> rcar {
> 	compatible ...
> 	reg...
>
> 	/* switch OVC for all three ports */
> 	renesas,rcar-ovc-port-config = <2 "high",
> 					1  "low",
> 					0  "high" >;

     Hm, 'dtc' allows mixed type properties now?
     Also, we need to describe the multiplexing of the OVCn pins (5V or 
3.3V input),
not only the active level.

> 	renesas,rcar-port1-mode = "host"; /* could also be peripheral */;

     You see, all this involves string type (and so more complex to deal 
with) props.
We were hoping to use only boolean props, more or less corresponding to 
the register bits...

> };
>
> Or something similar (not sure if the syntax is entirely correct).

    I'm not sure too.

> PENC
> apparently doesn't anything if it always needs to be set to 1.

    You've mixed it with some other pin -- it can be 0 or 1 in function 
mode.

> Would this work for you ?

     I should try... All this surely looks more complex than we would 
hope...

WBR, Sergei

