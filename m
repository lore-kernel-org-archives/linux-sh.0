From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Tue, 23 Feb 2016 06:49:23 +0000
Subject: Re: [PATCH] phy: rcar-gen3-usb2: remove HSUSB registers handling
Message-Id: <56CBFE23.8050501@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452158204-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20160109223307.GA14530@rob-hp-laptop>
 <SG2PR06MB0919A522615A7F9A90382CF2D8A40@SG2PR06MB0919.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB0919A522615A7F9A90382CF2D8A40@SG2PR06MB0919.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Rob Herring <robh@kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi,

On Tuesday 23 February 2016 11:54 AM, Yoshihiro Shimoda wrote:
> Hi Kishon,
> 
> Would you review this patch?

merged it now. Thanks for reminding.

-Kishon

> 
> I checked the latest linux-phy.git / next branch today,
> this patch can be applied on the top of branch.
> 
> commit 6b825eb7323a634cdd1014a4aa9a8ff07cf8040c
> Author: Heiko Stuebner <heiko@sntech.de>
> Date:   Mon Feb 22 12:55:01 2016 +0100
> 
>     phy: rockchip-usb: add handler for usb-uart functionality
> 
> Best regards,
> Yoshihiro Shimoda
> 
>> -----Original Message-----
>> From: Yoshihiro Shimoda
>> Sent: Tuesday, February 02, 2016 5:29 PM
>> To: kishon@ti.com
>> Cc: pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@codeaurora.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-sh@vger.kernel.org; 'Rob Herring' <robh@kernel.org>;
>> linux-renesas-soc@vger.kernel.org
>> Subject: RE: [PATCH] phy: rcar-gen3-usb2: remove HSUSB registers handling
>>
>> Hi Kishon,
>>
>> Would you review this patch?
>> I checked the latest linux-phy.git / next branch today, and it is the same as the following.
>>
>>>>  This patch is based on the linux-phy / next branch.
>>>>  (commit id = 9955a7835bf376e12482583958b2661f501b868b)
>>
>> Best regards,
>> Yoshihiro Shimoda
>>
>>> From: Rob Herring [mailto:robh@kernel.org]
>>> Sent: Sunday, January 10, 2016 7:33 AM
>>> To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>> Cc: kishon@ti.com; pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@codeaurora.org;
>>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-sh@vger.kernel.org
>>> Subject: Re: [PATCH] phy: rcar-gen3-usb2: remove HSUSB registers handling
>>>
>>> On Thu, Jan 07, 2016 at 06:16:44PM +0900, Yoshihiro Shimoda wrote:
>>>> Since the related driver (CPG/MSSR driver) only manages the first module
>>>> clock, this driver should not handle the HSUSB registers. So, this patch
>>>> removes the HSUSB registers handling.
>>>>
>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>> ---
>>>>  This patch is based on the linux-phy / next branch.
>>>>  (commit id = 9955a7835bf376e12482583958b2661f501b868b)
>>>>
>>>>  .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 15 ++--
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>>
>>>>  drivers/phy/phy-rcar-gen3-usb2.c                   | 83 +++-------------------
>>>>  2 files changed, 15 insertions(+), 83 deletions(-)
>>>
> 
