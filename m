From: Bastian Hecht <hechtb@gmail.com>
Date: Mon, 08 Apr 2013 15:22:44 +0000
Subject: Re: [RFC] ARM: shmobile: Armadillo800EVA: Replace GPIO function request
Message-Id: <CABYn4syDLxEaJW_CfAdC9Fm5-p+tEbvF3MHrqpgNxGaJVM-npA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365260483-25556-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365260483-25556-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2013/4/8 Bastian Hecht <hechtb@gmail.com>:
> Hi Laurent,
>
> 2013/4/7 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
>> Hi Bastian,
>>
>> Thanks for the patch.
>>
>> On Saturday 06 April 2013 17:01:23 Bastian Hecht wrote:
>>> We move to the new pinctrl framework to set up the function for the
>>> touchscreen IRQ.
>>>
>>> This is an RFC related to the discussion at
>>> [PATCH 6/6] ARM: shmobile: Armadillo800EVA: Reference DT implementation
>>>
>>> Not-signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>>> ---
>>>  arch/arm/mach-shmobile/board-armadillo800eva.c |    6 +++---
>>>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c           |   13 +++++++++++++
>>
>> Please split this in two patches.
>>
>>>  2 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c
>>> b/arch/arm/mach-shmobile/board-armadillo800eva.c index d82e67a..a1891f4
>>> 100644
>>> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
>>> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
>>> @@ -1064,6 +1064,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
>>>                                 "sdhi0_ctrl", "sdhi0"),
>>>       PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7740",
>>>                                 "sdhi0_wp", "sdhi0"),
>>> +     /* ST1232 */
>>> +     PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.0", "pfc-r8a7740",
>>
>> You should use the st1232 I2C device name here, not the I2C controller device
>> name.
>>
>>> +                               "intc_irq10", "intc"),
>>>  };
>>>
>>>  static void __init eva_clock_init(void)
>>> @@ -1124,9 +1127,6 @@ static void __init eva_init(void)
>>>       gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
>>>       gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
>>>
>>> -     /* Touchscreen */
>>> -     gpio_request(GPIO_FN_IRQ10,     NULL); /* TP_INT */
>>> -
>>>       /* GETHER */
>>>       gpio_request(GPIO_FN_ET_CRS,            NULL);
>>>       gpio_request(GPIO_FN_ET_MDC,            NULL);
>>> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
>>> b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index 21ff7f2..1810e56 100644
>>> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
>>> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
>>> @@ -1658,6 +1658,14 @@ static struct sh_pfc_pin pinmux_pins[] = {
>>>       GPIO_PORT_ALL(),
>>>  };
>>>
>>> +/* - INTC
>>> ------------------------------------------------------------------- */
>>> +static const unsigned int intc_irq10_pins[] = {
>>> +     /* IRQ */
>>> +     19,
>>> +};
>>> +static const unsigned int intc_irq10_mux[] = {
>>> +     IRQ10_MARK,
>>> +};
>>
>> While you're at it, could you please handle the other IRQs as well ? :-) As
>> there's many of them a macro such as the following would be useful.
>
> Phew... I'm taking a break and wonder if there has ever been a more
> boring work I've done in my computer carreer. If we meet some time I
> expect you to shout a drink for me as compensation!

On the other hand I better not complain considering the amount of data
that someone has placed there already... I might get poor if this
backfires.

>> #define IRQC_PINS_MUX(pin, mark)                                \
>> static const unsigned int intc_irq##mark##_pins[] = {           \
>>         pin,                                                    \
>> };                                                              \
>> static const unsigned int intc_irq##mark##_mux[] = {            \
>>         IRQ##mark##_MARK,                                       \
>> }
>>
>>>  /* - LCD0
>>> ------------------------------------------------------------------- */
>>> static const unsigned int lcd0_data8_pins[] = {
>>>       /* D[0:7] */
>>> @@ -2062,6 +2070,7 @@ static const unsigned int sdhi2_wp_1_mux[] = {
>>>  };
>>>
>>>  static const struct sh_pfc_pin_group pinmux_groups[] = {
>>> +     SH_PFC_PIN_GROUP(intc_irq10),
>>>       SH_PFC_PIN_GROUP(lcd0_data8),
>>>       SH_PFC_PIN_GROUP(lcd0_data9),
>>>       SH_PFC_PIN_GROUP(lcd0_data12),
>>> @@ -2112,6 +2121,10 @@ static const struct sh_pfc_pin_group pinmux_groups[]
>>> = { SH_PFC_PIN_GROUP(sdhi2_wp_1),
>>>  };
>>>
>>> +static const char * const intc_groups[] = {
>>> +     "intc_irq10",
>>> +};
>>> +
>>>  static const char * const lcd0_groups[] = {
>>>       "lcd0_data8",
>>>       "lcd0_data9",
>>
>> --
>> Regards,
>>
>> Laurent Pinchart
>>
