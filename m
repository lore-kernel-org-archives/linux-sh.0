From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 05 Jun 2014 16:30:26 +0000
Subject: Re: [PATCH 2/2] ARM: lager: add i2c1, i2c2 pins
Message-Id: <53909B22.9010701@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1392224674-5328-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392224674-5328-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 05/06/14 14:39, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/05/2014 04:32 AM, Simon Horman wrote:
> 
>>> Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
>>> to ensure these are setup correctly at initialisation time. The i2c0
>>> and i2c3 busses are connected to single function pins.
> 
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>>   arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
> 
>> I have queued up the following.
> 
>> There was some fuzz when applying this patch, please check that the
>> following is correct.
> 
>> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
>> [PATCH] ARM: shmobile: lager: add i2c1, i2c2 pins
> 
>> Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
>> to ensure these are setup correctly at initialisation time. The i2c0
>> and i2c3 busses are connected to single function pins.
> 
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> [horms+renesas@verge.net.au: Added shmobile to patch title]
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>   arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
>> b/arch/arm/boot/dts/r8a7790-lager.dts
>> index ee80788..e33ed0d 100644
>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>> @@ -139,6 +139,16 @@
>>           states = <3300000 1
>>                 1800000 0>;
>>       };
>> +
>> +    i2c1_pins: i2c1 {
>> +        renesas,groups = "i2c1";
>> +        renesas,function = "i2c1";
>> +    };
>> +
>> +    i2c2_pins: i2c2 {
>> +        renesas,groups = "i2c2";
>> +        renesas,function = "i2c2";
>> +    };
> 
>    These subnodes ended up added to a wrong node, they should have been
> added to the PFC node below.

Thanks, it is not obvious from just looking at them.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
