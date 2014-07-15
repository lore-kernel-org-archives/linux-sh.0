From: Daniel Palmer <danieruru@gmail.com>
Date: Tue, 15 Jul 2014 06:06:22 +0000
Subject: Re: [PATCH 1/1] SH7724 clock fixes: Fix the device name for the CMT Add a clock called usb0 so that 
Message-Id: <CAO64nm7NkXEoKYrtSPRO=6R-HR6bMcG2dD3jqSLLXJwWQ9sB4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sorry about that. It looked right with I committed it in git.
I'll add a clock for usb1 and send it again.

On Tue, Jul 15, 2014 at 3:02 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Daniel
>>
>> Signed-off-by: Daniel Palmer <danieruru@gmail.com>
>> ---
>
> For code,
>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> But, very long "Subject", and no git log :)
> You can separate it to short Subject and short log ?
>
>>  arch/sh/kernel/cpu/sh4a/clock-sh7724.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
>> index f579dd5..d37e7db 100644
>> --- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
>> +++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
>> @@ -307,7 +307,7 @@ static struct clk_lookup lookups[] = {
>>       CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[HWBLK_TMU0]),
>>       CLKDEV_ICK_ID("fck", "sh-tmu.1", &mstp_clks[HWBLK_TMU1]),
>>
>> -     CLKDEV_ICK_ID("fck", "sh-cmt-16.0", &mstp_clks[HWBLK_CMT]),
>> +     CLKDEV_ICK_ID("fck", "sh-cmt-32.0", &mstp_clks[HWBLK_CMT]),
>>       CLKDEV_DEV_ID("sh-wdt.0", &mstp_clks[HWBLK_RWDT]),
>>       CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[HWBLK_DMAC1]),
>>
>> @@ -332,6 +332,7 @@ static struct clk_lookup lookups[] = {
>>       CLKDEV_CON_ID("tsif0", &mstp_clks[HWBLK_TSIF]),
>>       CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[HWBLK_USB1]),
>>       CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[HWBLK_USB0]),
>> +     CLKDEV_CON_ID("usb0", &mstp_clks[HWBLK_USB0]),
>>       CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
>>       CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[HWBLK_SDHI0]),
>>       CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[HWBLK_SDHI1]),
>> --
>> 2.0.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
