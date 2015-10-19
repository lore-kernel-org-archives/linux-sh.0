From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Mon, 19 Oct 2015 11:50:48 +0000
Subject: Re: [PATCH v4 2/3] phy: rcar-gen3-usb2: change the mode to OTG on the combined channel
Message-Id: <5624D918.4040709@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444731726-5328-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <1444731726-5328-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <5621A8D4.40405@ti.com>
In-Reply-To: <5621A8D4.40405@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Toru Oishi <toru.oishi.zj@rvc.renesas.com>

Hi Kishon,

On 10/17/2015 8:48 AM, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Tuesday 13 October 2015 03:52 PM, Yoshihiro Shimoda wrote:
>> To use the channel 0 of R-Car gen3 as periperal mode, This patch changes
>> the mode to OTG instead of HOST. Then, this driver needs to set some
>> registers to enable host mode and detects ID pin and VBUS pin at
>> phy_init() timing.
>>
>> For now, the channel 0 can be used as host mode only.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>   drivers/phy/phy-rcar-gen3-usb2.c | 126 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 124 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
>> index d90dfcf..03d7079 100644
>> --- a/drivers/phy/phy-rcar-gen3-usb2.c
>> +++ b/drivers/phy/phy-rcar-gen3-usb2.c

[ .... ] snip

>> +
>> +	dev_dbg(&ch->phy->dev, "%s: %08x, %d\n", __func__, tmp, host);
>
> This shoulod be dev_vdbg.

I guess using dev_dbg() is equivalent.

I searched in same directory (drivers/phy) and the number of drivers 
using dev_vdbg() are just few drivers. (in my search, only 3 drivers). 
Other drivers use dev_dbg().
The last driver using dev_dbg was from Jan 2015.
I also recognized that dev_vdbug was used mostly in USB drivers...

Is it your favorite way or is there any good point of using dev_vdbg() ?

>> +	if (host)
>> +		tmp &= ~USB2_COMMCTRL_OTG_PERI;
>> +	else
>> +		tmp |= USB2_COMMCTRL_OTG_PERI;
>> +	writel(tmp, usb2_base + USB2_COMMCTRL);
>> +}
>> +
>> +static void rcar_gen3_set_linectrl(struct rcar_gen3_chan *ch, int dp, int dm)
>> +{
>> +	void __iomem *usb2_base = ch->usb2.base;
>> +	u32 tmp = readl(usb2_base + USB2_LINECTRL1);
>> +
>> +	dev_dbg(&ch->phy->dev, "%s: %08x, %d, %d\n", __func__, tmp, dp, dm);
>
> same here.

[.....] snip
>
> Thanks
> Kishon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

