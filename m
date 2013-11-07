From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 07 Nov 2013 15:47:20 +0000
Subject: Re: RCar-H2: boot from SD card request
Message-Id: <527BB608.2080303@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <527A828F.4060305@codethink.co.uk>
In-Reply-To: <527A828F.4060305@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/11/13 07:10, Magnus Damm wrote:
> Hi Ben,
>
> Unfortunately it seems to me that the upstream SDHI driver is lacking
> in some aspects. This means that it won't work on r8a7790 and r8a7791
> until it gets updated. We will do our best to cook up some code, would
> it be possible for you guys to test on your side?

Thanks, at the moment booting from SD card is much better for us than
assuming we have a network available.

I should have some time for testing in the near future.

> Cheers,
>
> / magnus
>
> On Thu, Nov 7, 2013 at 2:55 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> I am trying to boot an lager board from SD, using SDHI0 channel with
>> the development branches from Simon.
>>
>> Has anyone got this to work? I have a working 3.4-ltsi kernel that
>> can boot
>>
>> I've tried the next, master and devel branches from
>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
>>
>> My current diffs to the source are:
>>
>>> git diff
>>> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
>>> b/arch/arm/boot/dts/r8a7790-lager.dts
>>> index 203bd08..d2b33eb 100644
>>> --- a/arch/arm/boot/dts/r8a7790-lager.dts
>>> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
>>> @@ -16,7 +16,7 @@
>>>          compatible = "renesas,lager", "renesas,r8a7790";
>>>
>>>          chosen {
>>> -               bootargs = "console=ttySC6,115200 ignore_loglevel rw
>>> root=/dev/nfs ip=dhcp";
>>> +               bootargs = "console=ttySC6,38400 ignore_loglevel rw
>>> root=/dev/mmcblk0p1 rootwait";
>>>          };
>>>
>>>          memory@40000000 {
>>> @@ -29,3 +29,5 @@
>>>                  #size-cells = <1>;
>>>          };
>>>   };
>>> +
>>> +&sdhi0 { status = "ok"; };
>>
>>
>> --
>> Ben Dooks                               http://www.codethink.co.uk/
>> Senior Engineer                         Codethink - Providing Genius
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
