From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Wed, 14 Oct 2015 13:18:01 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <561E5609.3020100@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/14/2015 7:55 PM, Laurent Pinchart wrote:
> On Wednesday 14 October 2015 19:11:12 Khiem Nguyen wrote:
>> On 10/14/2015 3:22 PM, Geert Uytterhoeven wrote:
>>> On Wed, Oct 14, 2015 at 10:09 AM, Magnus Damm wrote:
>>>>> Or do you mean disabling them upfront?
>>>>> There are some clocks that must not be disabled. Some of them are not
>>>>> documented.
>>>>
>>>> Disabling them upfront with sparse documentation seems fun, but also a
>>>> bit like asking for trouble. =)
>>>
>>> I have hackish code that does it for all boards I have, and use it
>>> actively.
>>>
>>>> So disabling clocks upfront may be a troublesome but good way to
>>>> trigger incorrect dependencies, and unless I'm mistaken it should give
>>>> the same behaviour as the updated u-boot version, right?
>>>
>>> More or less (U-Boot still keeps a few enabled for its own use, e.g.
>>> Ethernet).
>>
>> AFAIK, in some recent versions of Gen2 BSP, all the devices (including
>> all devices enabled by u-boot for its processing, like Ethernet, TMU,
>> serial) will be turned off right before jumping to kernel start address.
>
> Would it make sense to keep the serial port enabled in order to support early
> printk ?
>

I don't think early printk is supported in Gen2 BSP, which is base on 
LTSI 3.10.
Geert has introduced early printk support for Gen2 in Nov 2014.

Maybe, we need to consider this point for Gen3.
