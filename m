From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 10:49:21 +0000
Subject: Re: [PATCH 4/6] phy-rcar-usb-gen2: add device tree support
Message-Id: <52DCFF31.2040603@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390057420-13226-1-git-send-email-ben.dooks@codethink.co.uk> <1390057420-13226-5-git-send-email-ben.dooks@codethink.co.uk> <52DAD3B3.1050807@cogentembedded.com>
In-Reply-To: <52DAD3B3.1050807@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>

On 18/01/14 19:19, Sergei Shtylyov wrote:
> Hello.
>
> On 18-01-2014 19:03, Ben Dooks wrote:
>
>> Add support for the phy-rcar-gen2-usb driver to be probed from device
>> tree.
>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
>> ---
>> Cc: linux-usb@vger.kernel.org (open list:USB PHY LAYER)
>> Cc: linux-sh@vger.kernel.org (open list:ARM/SHMOBILE ARM...)
>> Cc: Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM...)
>> Cc: Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM...)
>> Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND...)
>> ---
>>   drivers/usb/phy/phy-rcar-gen2-usb.c | 35
>> ++++++++++++++++++++++++++++++-----
>>   1 file changed, 30 insertions(+), 5 deletions(-)
>
>> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c
>> b/drivers/usb/phy/phy-rcar-gen2-usb.c
>> index db3ab34..906b74b 100644
>> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
>> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
> [...]
>> @@ -177,8 +185,9 @@ static int rcar_gen2_usb_phy_probe(struct
>> platform_device *pdev)
>>       struct clk *clk;
>>       int retval;
>>
>> +    of_id = of_match_device(rcar_gen2_usb_phy_ofmatch, &pdev->dev);
>
>     I don't think another match is needed.
>
>>       pdata = dev_get_platdata(&pdev->dev);
>> -    if (!pdata) {
>> +    if (!pdata && !of_id) {
>>           dev_err(dev, "No platform data\n");
>>           return -EINVAL;
>>       }
>> @@ -203,16 +212,31 @@ static int rcar_gen2_usb_phy_probe(struct
>> platform_device *pdev)
> [...]
>> +    if (of_id) {
>
>     Isn't checking dev->of_node enough?

of_node does not contain the id of the entry matched at start time/

>> +        int len = 0;
>> +
>> +        if (of_get_property(dev->of_node, "renesas,usb0-hs", &len))
>> +            priv->ugctrl2 = USBHS_UGCTRL2_USB0_HS;
>> +        else
>> +            priv->ugctrl2 = USBHS_UGCTRL2_USB0_PCI;
>> +
>> +        if (of_get_property(dev->of_node, "renesas,usb2-ss", &len))
>> +            priv->ugctrl2 |= USBHS_UGCTRL2_USB2_SS;
>
>     Where is the bindings file you document these properties in?

Should have been in another patch in the series.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
