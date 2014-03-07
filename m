From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 07 Mar 2014 16:22:39 +0000
Subject: Re: [PATCH 2/5] ARM: lager: add vin1 node
Message-Id: <531A0065.3060001@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk> <1394197299-17528-3-git-send-email-ben.dooks@codethink.co.uk> <5319F8D1.5050608@cogentembedded.com> <5319EE73.7010305@codethink.co.uk>
In-Reply-To: <5319EE73.7010305@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-media@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-kernel@vger.kernel.org, magnus.damm@opensource.se, linux-sh@vger.kernel.org, linux-kernel@lists.codethink.co.uk

On 03/07/2014 07:06 PM, Ben Dooks wrote:

>>> Add device-tree for vin1 (composite video in) on the
>>> lager board.

>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

>>     This patch should have been preceded by the VIN driver patch and
>> bindings description, don't you think?

>>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
>>> b/arch/arm/boot/dts/r8a7790-lager.dts
>>> index a087421..7528cfc 100644
>>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>> [...]
>>> @@ -239,8 +244,41 @@
>>>       status = "ok";
>>>       pinctrl-0 = <&i2c2_pins>;
>>>       pinctrl-names = "default";
>>> +
>>> +    adv7180: adv7180@0x20 {

>>     ePAPR standard [1] tells us that:

>> "The name of a node should be somewhat generic, reflecting the function
>> of the device and not its precise programming model."

>>     So, I would suggest something like "video-decoder" instead. And
>> remove "0x" from the address part of the node name please.

> Personally I'm not fussed about names in the tree.

    I quoted the standard everybody should follow.

> I will look at changing it to something like vin1_decoder

    Please give it a generic name instead, without indexes and underscores.

WBR, Sergei

