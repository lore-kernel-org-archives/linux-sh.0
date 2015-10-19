From: Hamza Farooq <hamzahfrq.sub@gmail.com>
Date: Mon, 19 Oct 2015 20:58:08 +0000
Subject: Re: [PATCH v3 5/6] dma: rcar-dma: warn if transfer cannot start as TE = 1
Message-Id: <CAJ--JmzD6kjGPh-xyLKJpVtmtcnr0K1Z1Q+VFkX0KkrkMuSk_Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-6-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-6-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,


On Thu, Oct 15, 2015 at 6:53 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Muhammad,
>
> Thank you for the patch.
>
> On Tuesday 29 September 2015 22:44:47 hamzahfrq.sub@gmail.com wrote:
>> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
>>
>> Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
>> ---
>>  drivers/dma/sh/rcar-dmac.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
>> index 0b5a367..6eec878 100644
>> --- a/drivers/dma/sh/rcar-dmac.c
>> +++ b/drivers/dma/sh/rcar-dmac.c
>> @@ -327,7 +327,8 @@ static void rcar_dmac_chan_start_xfer(struct
>> rcar_dmac_chan *chan) struct rcar_dmac_desc *desc = chan->desc.running;
>>       u32 chcr = desc->chcr;
>>
>> -     WARN_ON_ONCE(rcar_dmac_chan_is_busy(chan));
>> +     WARN_ON_ONCE(rcar_dmac_chan_is_busy(chan) ||
>> +                     rcar_dmac_last_tx_complete(chan));
>
> Why is that a problem ?

According to the datasheet, new dma transfer cannot start new transfer
if TE = 1. May be rcar_dmac_last_tx_complete is a misnomer. It is used
when TE is set to 1 by hardware but the ISR has not yet run

>
>>       if (chan->mid_rid >= 0)
>>               rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
>
> --
> Regards,
>
> Laurent Pinchart
>
