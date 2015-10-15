From: Hamza Farooq <hamzahfrq.sub@gmail.com>
Date: Thu, 15 Oct 2015 16:02:09 +0000
Subject: Re: [PATCH 1/6] dma: rcar-dma: add wait after stopping dma engine
Message-Id: <CAJ--JmzaOgpMvLzE=dVuhbHezxLPfnc1=7dRq48u638TLdwdkw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

> Hmmm, why is threading broken in this series?
> Also why is this PATCH 1/6 whereas the rest of series is v3!
>
> Right way is to let git do this for you and use git format-patch
> --subject-prefix="PATCH v3"...
>
> You don't do these things manually, that would be terrible waste of time
>
> Also use git send-email to keep threading
I will keep that in mind

>> +#define NR_READS_TO_WAIT 5 /* number of times to check if DE = 0 */
>> +static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
>> +{
>> +     unsigned int i = 0;
>> +
>> +     do {
>> +             u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>> +
>> +             if (!(chcr & RCAR_DMACHCR_DE))
>> +                     return 0;
>> +             cpu_relax();
>> +             dev_dbg(chan->chan.device->dev, "DMA xfer couldn't be stopped");
>
> And user has no way of knowing this on production system
What do you suggest here instead?


>> +/* Called with chan lock held */
>> +static int rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
>>  {
>> -     u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>> +     u32 chcr;
>> +     int ret;
>>
>> +     chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>>       chcr &= ~(RCAR_DMACHCR_DSE | RCAR_DMACHCR_DSIE | RCAR_DMACHCR_IE |
>>                 RCAR_DMACHCR_TE | RCAR_DMACHCR_DE);
>>       rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
>> +     ret = rcar_dmac_wait_stop(chan);
>> +
>> +     WARN_ON(ret < 0);
>
> What if we have broken board and will see dmesg storm for this, perhaps
> WARN_ON_ONCE and also would be helpful to use the verbose version and print
> some meaningful message

Yes that does make sense. I shall update it in next version

Thanks for the comments

Best,
Hamza


On Mon, Oct 12, 2015 at 4:59 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Sep 29, 2015 at 10:44:43PM +0200, hamzahfrq.sub@gmail.com wrote:
>> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
>>
>> DMA engine does not stop instantaneously when transaction is going on
>> (see datasheet). Wait has been added
>
> Hmmm, why is threading broken in this series?
> Also why is this PATCH 1/6 whereas the rest of series is v3!
>
> Right way is to let git do this for you and use git format-patch
> --subject-prefix="PATCH v3"...
>
> You don't do these things manually, that would be terrible waste of time
>
> Also use git send-email to keep threading
>
>> Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
>> ---
>>  drivers/dma/sh/rcar-dmac.c | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
>> index 7820d07..2b28291 100644
>> --- a/drivers/dma/sh/rcar-dmac.c
>> +++ b/drivers/dma/sh/rcar-dmac.c
>> @@ -716,14 +716,38 @@ static int rcar_dmac_fill_hwdesc(struct rcar_dmac_chan *chan,
>>  /* -----------------------------------------------------------------------------
>>   * Stop and reset
>>   */
>> +#define NR_READS_TO_WAIT 5 /* number of times to check if DE = 0 */
>> +static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
>> +{
>> +     unsigned int i = 0;
>> +
>> +     do {
>> +             u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>> +
>> +             if (!(chcr & RCAR_DMACHCR_DE))
>> +                     return 0;
>> +             cpu_relax();
>> +             dev_dbg(chan->chan.device->dev, "DMA xfer couldn't be stopped");
>
> And user has no way of knowing this on production system
>
>> +     } while (++i < NR_READS_TO_WAIT);
>>
>> -static void rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
>> +     return -EBUSY;
>> +}
>> +
>> +/* Called with chan lock held */
>> +static int rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
>>  {
>> -     u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>> +     u32 chcr;
>> +     int ret;
>>
>> +     chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>>       chcr &= ~(RCAR_DMACHCR_DSE | RCAR_DMACHCR_DSIE | RCAR_DMACHCR_IE |
>>                 RCAR_DMACHCR_TE | RCAR_DMACHCR_DE);
>>       rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
>> +     ret = rcar_dmac_wait_stop(chan);
>> +
>> +     WARN_ON(ret < 0);
>
> What if we have broken board and will see dmesg storm for this, perhaps
> WARN_ON_ONCE and also would be helpful to use the verbose version and print
> some meaningful message
>
> --
> ~Vinod
