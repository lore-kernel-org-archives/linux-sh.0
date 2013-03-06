From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Mar 2013 07:53:06 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <CANqRtoR_k2tRiUgUYEeJMnSb0vsU8zMJzz6QQxWeWnu90GhtFw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 6, 2013 at 2:51 AM,  <phil.edworthy@renesas.com> wrote:
> Hi Morimoto-san, Simon,
>
>> Subject: [PATCH] sh-pfc: r8a7779: fixup INDTx address
>> Sent by: linux-sh-owner@vger.kernel.org
>>
>> INDTn address is 0xFFC4x000C. 0xFFC4x0008 is OUTDTn
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/
>> sh-pfc/pfc-r8a7779.c
>> index 13feaa0..cb97fb6 100644
>> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
>> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
>> @@ -2585,13 +2585,13 @@ static struct pinmux_cfg_reg
> pinmux_config_regs[] = {
>>  };
>>
>>  static struct pinmux_data_reg pinmux_data_regs[] = {
>> -   { PINMUX_DATA_REG("INDT0", 0xffc40008, 32) { GP_INDT(0) } },
>> -   { PINMUX_DATA_REG("INDT1", 0xffc41008, 32) { GP_INDT(1) } },
>> -   { PINMUX_DATA_REG("INDT2", 0xffc42008, 32) { GP_INDT(2) } },
>> -   { PINMUX_DATA_REG("INDT3", 0xffc43008, 32) { GP_INDT(3) } },
>> -   { PINMUX_DATA_REG("INDT4", 0xffc44008, 32) { GP_INDT(4) } },
>> -   { PINMUX_DATA_REG("INDT5", 0xffc45008, 32) { GP_INDT(5) } },
>> -   { PINMUX_DATA_REG("INDT6", 0xffc46008, 32) {
>> +   { PINMUX_DATA_REG("INDT0", 0xffc4000c, 32) { GP_INDT(0) } },
>> +   { PINMUX_DATA_REG("INDT1", 0xffc4100c, 32) { GP_INDT(1) } },
>> +   { PINMUX_DATA_REG("INDT2", 0xffc4200c, 32) { GP_INDT(2) } },
>> +   { PINMUX_DATA_REG("INDT3", 0xffc4300c, 32) { GP_INDT(3) } },
>> +   { PINMUX_DATA_REG("INDT4", 0xffc4400c, 32) { GP_INDT(4) } },
>> +   { PINMUX_DATA_REG("INDT5", 0xffc4500c, 32) { GP_INDT(5) } },
>> +   { PINMUX_DATA_REG("INDT6", 0xffc4600c, 32) {
>>        0, 0, 0, 0, 0, 0, 0, 0,   0, 0, 0, 0, 0, 0, 0, 0,
>>        0, 0, 0, 0, 0, 0, 0, GP_6_8_DATA,
>>        GP_6_7_DATA, GP_6_6_DATA, GP_6_5_DATA, GP_6_4_DATA,
>
> Hmm, this isn't what you want. I sent a similar patch on this a while back
> before realising that the problem is that the pfc driver doesn't support
> separate input and output data registers, only one reg for both input and
> output. With the code as it is, the gpio pins act as outputs. Changing the
> addresses as per this patch means the gpios act now as inputs.

Hi Phil,

Thanks for guiding people in the right direction. GPIOS on r8a7779 is
a bit tricky in general. Both IN and OUT registers as well as IRQ
demux support.

From my point of view, switching to the recently posted gpio-rcar.c
driver should take care of all these issues.
[PATCH] gpio: Renesas R-Car GPIO driver

We do however need to work on how to make GPIO and PFC coexist.

Cheers,

/ magnus
