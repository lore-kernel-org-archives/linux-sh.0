From: "Christian Daudt" <csd@broadcom.com>
Date: Tue, 14 May 2013 14:58:52 +0000
Subject: Re: [PATCH 06/14] ARM: bcm281xx: Remove init_irq declaration in machine description
Message-Id: <5192512C.6080006@broadcom.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-7-git-send-email-maxime.ripard@free-electrons.com>
 <519147C6.6080004@broadcom.com> <5191F503.2070301@free-electrons.com>
In-Reply-To: <5191F503.2070301@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 13-05-14 01:25 AM, Maxime Ripard wrote:
> Hi Christian,
>
> Le 13/05/2013 22:06, Christian Daudt a =E9crit :
>> On 13-05-13 02:44 AM, Maxime Ripard wrote:
>>> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
>>> specified") removed the need to explictly setup the init_irq field in
>>> the machine description when using only irqchip_init. Remove that
>>> declaration for bcm281xx as well.
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>    arch/arm/mach-bcm/board_bcm.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-bcm/board_bcm.c
>>> b/arch/arm/mach-bcm/board_bcm.c
>>> index 22e8421..24556cf 100644
>>> --- a/arch/arm/mach-bcm/board_bcm.c
>>> +++ b/arch/arm/mach-bcm/board_bcm.c
>>> @@ -54,7 +54,6 @@ static void __init board_init(void)
>>>    static const char * const bcm11351_dt_compat[] =3D { "bcm,bcm11351",
>>> NULL, };
>>>      DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
>>> -    .init_irq =3D irqchip_init,
>>>        .init_time =3D clocksource_of_init,
>>>        .init_machine =3D board_init,
>>>        .dt_compat =3D bcm11351_dt_compat,
>> Acked-by: Christian Daudt <csd@broadcom.com>
> Thanks!
>
> I forgot to remove the include of irqchip.h into all these patches, so
> I'll send a v2, and I guess you could probably merge it through your
> tree after that directly.
Ok. will do.

  thanks,
    csd



