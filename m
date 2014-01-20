From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 12:24:34 +0000
Subject: Re: [PATCH 4/6] phy-rcar-usb-gen2: add device tree support
Message-Id: <52DD1582.3000304@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390057420-13226-1-git-send-email-ben.dooks@codethink.co.uk> <1390057420-13226-5-git-send-email-ben.dooks@codethink.co.uk> <52DD141F.3040704@cogentembedded.com>
In-Reply-To: <52DD141F.3040704@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, "list@codethink.co.uk:USB PHY LAYER" <linux-usb@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, devicetree@vger.kernel.org

On 20/01/14 12:18, Sergei Shtylyov wrote:
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
>> @@ -203,16 +212,31 @@ static int rcar_gen2_usb_phy_probe(struct
>> platform_device *pdev)
> [...]
>> +    if (of_id) {
>> +        int len = 0;
>> +
>> +        if (of_get_property(dev->of_node, "renesas,usb0-hs", &len))
>> +            priv->ugctrl2 = USBHS_UGCTRL2_USB0_HS;
>> +        else
>> +            priv->ugctrl2 = USBHS_UGCTRL2_USB0_PCI;
>> +
>> +        if (of_get_property(dev->of_node, "renesas,usb2-ss", &len))
>
>     You can use of_property_read_bool() in both cases as both these
> props are boolean I guess. It's more handy.

Thanks, missed that one, will sort that out.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
