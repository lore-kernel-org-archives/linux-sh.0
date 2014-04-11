From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 11 Apr 2014 12:23:17 +0000
Subject: Re: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <5347DEB5.9070802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 11-04-2014 4:39, Kuninori Morimoto wrote:

> Thank you for your review

>>> -static const struct resource du_resources[] __initconst = {
>>> -       DEFINE_RES_MEM(0xfeb00000, 0x70000),
>>> -       DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
>>> -       DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
>>> -       DEFINE_RES_IRQ(gic_spi(256)),
>>> -       DEFINE_RES_IRQ(gic_spi(268)),
>>> -       DEFINE_RES_IRQ(gic_spi(269)),
>>> -};
>>> -
>>>   static void __init lager_add_du_device(void)
>>>   {
>>> +       struct resource du_resources[] = {
>>> +               DEFINE_RES_MEM(0xfeb00000, 0x70000),
>>> +               DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
>>> +               DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
>>> +               DEFINE_RES_IRQ(gic_spi(256)),
>>> +               DEFINE_RES_IRQ(gic_spi(268)),
>>> +               DEFINE_RES_IRQ(gic_spi(269)),
>>> +       };

>> Shouldn't the above retain the "static const"?
>> Without the static, there will be additonal code to perform the initialization
>> on the stack.

> "static" is not needed.

    It is needed in order to avoid the extra local variable initialization 
code in this function -- exactly what Geert said.

> Becouse ...

> platform_device_register_xxx()
>   -> platform_device_register_full()
>     -> platform_device_add_resources()
>     -> platform_device_add_data()

> platform_device_add_resources/data() are using kmemdup().
> This means, driver uses alloced and copied resource/data,
> not above one.

    You are answering the question Geert didn't ask. :-)

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei

