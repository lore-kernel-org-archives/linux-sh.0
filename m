From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 27 Feb 2014 16:03:16 +0000
Subject: Re: [PATCH 4/6] phy-rcar-usb-gen2: add device tree support
Message-Id: <530F61C4.7070706@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390057420-13226-1-git-send-email-ben.dooks@codethink.co.uk> <1390057420-13226-5-git-send-email-ben.dooks@codethink.co.uk> <52DAD3B3.1050807@cogentembedded.com> <52DCFF31.2040603@codethink.co.uk> <530F5FC2.1000608@cogentembedded.com>
In-Reply-To: <530F5FC2.1000608@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>

On 27/02/14 15:54, Sergei Shtylyov wrote:
> Hello.
>
> On 20-01-2014 14:49, Ben Dooks wrote:
>
>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
>>>> ---
>>>> Cc: linux-usb@vger.kernel.org (open list:USB PHY LAYER)
>>>> Cc: linux-sh@vger.kernel.org (open list:ARM/SHMOBILE ARM...)
>>>> Cc: Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM...)
>>>> Cc: Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM...)
>>>> Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND...)
>>>> ---
>>>>   drivers/usb/phy/phy-rcar-gen2-usb.c | 35
>>>> ++++++++++++++++++++++++++++++-----
>>>>   1 file changed, 30 insertions(+), 5 deletions(-)
>
>>>> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c
>>>> b/drivers/usb/phy/phy-rcar-gen2-usb.c
>>>> index db3ab34..906b74b 100644
>>>> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
>>>> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
>>> [...]
>>>> @@ -203,16 +212,31 @@ static int rcar_gen2_usb_phy_probe(struct
>>>> platform_device *pdev)
>>> [...]
>>>> +    if (of_id) {
> [...]
>>>> +        int len = 0;
>>>> +
>>>> +        if (of_get_property(dev->of_node, "renesas,usb0-hs", &len))
>>>> +            priv->ugctrl2 = USBHS_UGCTRL2_USB0_HS;
>>>> +        else
>>>> +            priv->ugctrl2 = USBHS_UGCTRL2_USB0_PCI;
>>>> +
>>>> +        if (of_get_property(dev->of_node, "renesas,usb2-ss", &len))
>>>> +            priv->ugctrl2 |= USBHS_UGCTRL2_USB2_SS;
>
>>>     Where is the bindings file you document these properties in?
>
>> Should have been in another patch in the series.
>
>     I didn't see it.

I thought it went out, I will need to go check.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
