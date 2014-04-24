From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 24 Apr 2014 18:48:10 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <53595C6A.6080004@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/24/2014 09:45 AM, Magnus Damm wrote:

>> [...]

>>>>>>> A simple serial port integration prototype that happens to
>>>>>>> target Koelsch. Written to propose how to move one step closer
>>>>>>> to integrate DT support for serial ports on mach-shmobile.

>>>>>> I think you've over-engineering it. I would just switch serial devices
>>>>>> to
>>>>>> DT in one go, like we do for all other devices.

>>>>> I agree about the risk of over-engineering! =)

>>>>> At the same time I would like to integrate your serial DT support as
>>>>> soon as
>>>>> possible. Order wise I'd like to integrate your serial DT support before
>>>>> phasing out legacy board code. We can of course discuss the order, but
>>>>> if we
>>>>> first integrate serial DT then we end up with 3 different serial cases

>>>> The fact that we even have 3 different cases (DT only, C DT reference and
>>>> C
>>>> legacy) shows that there's a problem. We started with C code that we
>>>> forked
>>>> into C DT reference code instead of porting the C code over to DT, and
>>>> now we
>>>> want to keep using platform devices in the C DT reference code ? Come
>>>> on...

>>> What is the problem? We need to encourage development and also provide
>>> a stable base. And from my point of view, you're not even supposed to
>>> use the C DT reference code as a developer - you should use DT-only
>>> board support for development.

>>     I wonder how DT-only support (without C reference code) is possible with
>> the current devel branch: only board-{lager|koelsch}-reference.c include
>> call to of_platform_populate() without which DT probing drivers won't see
>> their devices. If we had that call in the setup-r8a779[01].c then I would
>> have understood what you mean by DT-only...

> I believe the machine vector in setup-r8a779x.c is enough at this
> point, perhaps you don't are missing the default case when certain
> callbacks are left as NULL?

    Ah, indeed, init_machine() is missing and in this case 
of_platform_populate() is called! Thank you, it wasn't obvious to me.

> / magnus

WBR, Sergei

