From: Hamza Farooq <hamzahfrq.sub@gmail.com>
Date: Mon, 19 Oct 2015 20:54:53 +0000
Subject: Re: [PATCH 1/6] dma: rcar-dma: add wait after stopping dma engine
Message-Id: <CAJ--Jmxd=RgbdcgjE0ztf_WZG7brz8BTqU-_WsLg+PW0qu4Utw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,



On Thu, Oct 15, 2015 at 10:42 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hello Hamza,
>
> (With a question for Morimoto-san below)
>
> On Thursday 15 October 2015 18:08:56 Hamza Farooq wrote:
>> Hi Laurent,
>>
>> Thank you for the review. Please see my comments below. Also please let me
>> know if this code needs to be fixed on somewhat urgent basis since I am a
>> little occupied with few other tasks. I'd try to prioritize it then
>
> I don't think this is urgent, so no worries.
>
>> On Thu, Oct 15, 2015 at 5:58 PM, Laurent Pinchart wrote:
>> > On Tuesday 29 September 2015 22:44:43 hamzahfrq.sub@gmail.com wrote:
>> >> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
>> >>
>> >> DMA engine does not stop instantaneously when transaction is going on
>> >> (see datasheet). Wait has been added
>> >>
>> >> Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
>> >> ---
>> >>
>> >>  drivers/dma/sh/rcar-dmac.c | 28 ++++++++++++++++++++++++++--
>> >>  1 file changed, 26 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
>> >> index 7820d07..2b28291 100644
>> >> --- a/drivers/dma/sh/rcar-dmac.c
>> >> +++ b/drivers/dma/sh/rcar-dmac.c
>> >> @@ -716,14 +716,38 @@ static int rcar_dmac_fill_hwdesc(struct
>> >> rcar_dmac_chan *chan,
>> >> /* ----------------------------------------------------------------------
>> >>  * Stop and reset
>> >>  */
>> >>
>> >> +#define NR_READS_TO_WAIT 5 /* number of times to check if DE = 0 */
>> >> +static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
>> >> +{
>> >> +     unsigned int i = 0;
>> >> +
>> >> +     do {
>> >> +             u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>> >> +
>> >> +             if (!(chcr & RCAR_DMACHCR_DE))
>> >> +                     return 0;
>> >> +             cpu_relax();
>> >> +             dev_dbg(chan->chan.device->dev, "DMA xfer couldn't be
>> >> stopped");
>> >>
>> > Would it make sense to move the message out of the loop and use dev_err()
>> > ? It seems like a pretty serious error.
>>
>> It happens quite often so dev_err might be too noisy. After couple
>> attempts (1-3) it stops so I think it is better to not make it dev_err
>
> That's why I mentioned moving it outside of the loop and only printing it when
> the DMA channel doesn't stop.

I don't think it is a good idea to notify the user again and again
about it, specially when it is handled by this patch. It occurs quite
a lot (for me, a lot means around 10 times for a data transfer of 7 MB
over sh-sci at 150 kbps)

>
>> >> +     } while (++i < NR_READS_TO_WAIT);
>> >
>> > How long does the DMA engine typically need to stop ? Is there a safe
>> > upper bound ?
>>
>> I have tested it many times. The highest number of retries was 3 which
>> occurred not very frequently. Normally it is 1-2
>
> Morimoto-san, could you check with the hardware team if there's a worst case
> guarantee regarding how long the channel could take to stop ?
>
>> >> -static void rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
>> >> +     return -EBUSY;
>> >> +}
>> >> +
>> >> +/* Called with chan lock held */
>> >> +static int rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
>> >>  {
>> >> -     u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>> >> +     u32 chcr;
>> >> +     int ret;
>> >>
>> >> +     chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>> >>       chcr &= ~(RCAR_DMACHCR_DSE | RCAR_DMACHCR_DSIE | RCAR_DMACHCR_IE |
>> >>                 RCAR_DMACHCR_TE | RCAR_DMACHCR_DE);
>> >>       rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
>> >> +     ret = rcar_dmac_wait_stop(chan);
>> >
>> > As the rcar_dmac_wait_stop() function is used here only I'd inline the
>> > code directly.
>>
>> It is used in DMA_PAUSE operation as well
>
> Let's resolve the DMA pause issue and then decide :-)
>
>> >> +
>> >> +     WARN_ON(ret < 0);
>> >
>> > If you use dev_err() instead of dev_dbg() above you could remove the
>> > WARN_on.
>>
>> see comment about dev_err above
>>
>> >> +
>> >> +     return ret;
>> >>  }
>> >>
>> >>  static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
>
> --
> Regards,
>
> Laurent Pinchart
>

Best,
Hamza
