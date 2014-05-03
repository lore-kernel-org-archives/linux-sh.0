From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 03 May 2014 19:23:28 +0000
Subject: Re: [PATCH 4/5][RESENT] mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7790
Message-Id: <CANqRtoSmAcny1X_Qa67LQF9uASoVSPJUFcPuFvQdb4O-XnWtBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
	<878ut5qo9d.wl%kuninori.morimoto.gx@gmail.com>
	<8738jdqo78.wl%kuninori.morimoto.gx@gmail.com>
	<5364305C.7090005@cogentembedded.com>
In-Reply-To: <5364305C.7090005@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Hi Sergei,

On Fri, May 2, 2014 at 11:55 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 02/21/2014 03:55 AM, Kuninori Morimoto wrote:
>
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
>
>> This patch updates r8a7790 DT data to have SoC specific settings.
>
>
>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>   drivers/mmc/host/sh_mobile_sdhi.c |   10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>
>
>> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c
>> b/drivers/mmc/host/sh_mobile_sdhi.c
>> index 38acf26..cfc37ec 100644
>> --- a/drivers/mmc/host/sh_mobile_sdhi.c
>> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
>
> [...]
>
>> @@ -51,6 +52,12 @@ static const struct sh_mobile_sdhi_of_data
>> of_rcar_gen1_compatible = {
>>         .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>>   };
>>
>> +static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
>> +       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT |
>> TMIO_MMC_WRPROTECT_DISABLE,
>
>
>    Hm, I think SDHI0/1 still have the WP signal, only SDHI2 on Koelsch lacks
> it due to using micro-SD slot?..

This has been design this way intentionally. Basically, we don't want
any board specific code in any driver and the WP signal is a very
board specific property. So we default to not using WP, but let the
user hook in GPIO via DT in case it is used on a particular instance
on a particular board. If we do it the other way around and enable by
default then we would have to implement disabling of WP in DT which is
just strange. If done wrong then the micro-SD cards may end up with
incorrect WP signal state (read only?). So letting board code hook in
board specific bits via DT seems like the only sane way forward in my
mind.

Is there anything related to WP and CD that does not work for you?

Thanks,

/ magnus
