From: Hamza Farooq <hamzahfrq.sub@gmail.com>
Date: Tue, 20 Oct 2015 12:30:43 +0000
Subject: Re: [PATCH 1/6] dma: rcar-dma: add wait after stopping dma engine
Message-Id: <CAJ--Jmz3a+J3mnZ9MH3VZg8R0CH9Vma5fkeR9DUGxwxULFd0nA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Oct 19, 2015 at 11:06 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Hamza,
>
> On Monday 19 October 2015 22:54:53 Hamza Farooq wrote:
>> On Thu, Oct 15, 2015 at 10:42 PM, Laurent Pinchart wrote:
>> > On Thursday 15 October 2015 18:08:56 Hamza Farooq wrote:
>> >> Hi Laurent,
>> >>
>> >> Thank you for the review. Please see my comments below. Also please let
>> >> me know if this code needs to be fixed on somewhat urgent basis since I
>> >> am a little occupied with few other tasks. I'd try to prioritize it then
>> >
>> > I don't think this is urgent, so no worries.
>> >
>> >> On Thu, Oct 15, 2015 at 5:58 PM, Laurent Pinchart wrote:
>> >> > On Tuesday 29 September 2015 22:44:43 hamzahfrq.sub@gmail.com wrote:
>> >> >> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
>> >> >>
>> >> >> DMA engine does not stop instantaneously when transaction is going on
>> >> >> (see datasheet). Wait has been added
>> >> >>
>> >> >> Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
>> >> >> ---
>> >> >>
>> >> >>  drivers/dma/sh/rcar-dmac.c | 28 ++++++++++++++++++++++++++--
>> >> >>  1 file changed, 26 insertions(+), 2 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
>> >> >> index 7820d07..2b28291 100644
>> >> >> --- a/drivers/dma/sh/rcar-dmac.c
>> >> >> +++ b/drivers/dma/sh/rcar-dmac.c
>> >> >> @@ -716,14 +716,38 @@ static int rcar_dmac_fill_hwdesc(struct
>> >> >> rcar_dmac_chan *chan,
>> >> >> /* -------------------------------------------------------------------
>> >> >>  * Stop and reset
>> >> >>  */
>> >> >>
>> >> >> +#define NR_READS_TO_WAIT 5 /* number of times to check if DE = 0 */
>> >> >> +static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
>> >> >> +{
>> >> >> +     unsigned int i = 0;
>> >> >> +
>> >> >> +     do {
>> >> >> +             u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>> >> >> +
>> >> >> +             if (!(chcr & RCAR_DMACHCR_DE))
>> >> >> +                     return 0;
>> >> >> +             cpu_relax();
>> >> >> +             dev_dbg(chan->chan.device->dev, "DMA xfer couldn't be
>> >> >> stopped");
>> >> >
>> >> > Would it make sense to move the message out of the loop and use
>> >> > dev_err() ? It seems like a pretty serious error.
>> >>
>> >> It happens quite often so dev_err might be too noisy. After couple
>> >> attempts (1-3) it stops so I think it is better to not make it dev_err
>> >
>> > That's why I mentioned moving it outside of the loop and only printing it
>> > when the DMA channel doesn't stop.
>>
>> I don't think it is a good idea to notify the user again and again
>> about it, specially when it is handled by this patch. It occurs quite
>> a lot (for me, a lot means around 10 times for a data transfer of 7 MB
>> over sh-sci at 150 kbps)
>
> I think there's some miscommunication going on. What I meant is
>
> #define NR_READS_TO_WAIT 5 /* number of times to check if DE = 0 */
>
> static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
> {
>         unsigned int i;
>
>         for (i = 0; i < NR_READS_TO_WAIT; ++i) {
>                 u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>
>                 if (!(chcr & RCAR_DMACHCR_DE))
>                         return 0;
>                 cpu_relax();
>         }
>
>         dev_err(chan->chan.device->dev, "DMA xfer couldn't be stopped");
>         return -EBUSY;
> }

ah ok, I understood it as displaying error every time it does not
stop. Yea this makes sense. As a DMA engine user, I would like to see
the information in at least debug output though, that DMA did not stop
in first attempt. So what do you say about keeping the dev_dbg message
in the loop and adding your line (dev_err) outside?

>
> --
> Regards,
>
> Laurent Pinchart
>
