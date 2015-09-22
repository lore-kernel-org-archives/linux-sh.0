From: Hamza Farooq <hamzahfrq.sub@gmail.com>
Date: Tue, 22 Sep 2015 07:41:46 +0000
Subject: Re: [RESEND PATCH 1/6] dma: rcar-dma: add wait after stopping dma engine
Message-Id: <CAJ--JmxF_=ZaOpD9OO_6oBOzuyU2GvtO5b+p+NdNpAUQG2tjPw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442776262-2503-2-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1442776262-2503-2-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

From: Sergei Shtylyov [mailto:sergei.shtylyov@cogentembedded.com]

>>>> +static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
>>>> +{
>>>> +       unsigned int i = 0;
>>>> +
>>>> +       do {
>>>> +               u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>>>> +
>>>> +               if (!(chcr & RCAR_DMACHCR_DE))
>>>> +                       return 0;
>>>> +               cpu_relax();
>>>> +               dev_dbg(chan->chan.device->dev, "DMA xfer couldn't be stopped");
>>>> +       } while (++i < NR_READS_TO_WAIT);
>>>
>>>     Hm, this can be a *for* loop, no?
>
>> Could you explain why would you prefer a for loop here? do..while
>> makes sure even if NR_READS_TO_WAIT is set to 0, the stop action takes
>> place
>
>    Hm, this doesn't make sense to me. If # of reads is 0, we shouldn't read, no?
The datasheet states that we have to wait after a write. I have used
do..while to impose this check

Best,
Hamza



On Mon, Sep 21, 2015 at 7:39 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 09/21/2015 02:30 PM, Hamza Farooq wrote:
>
>>>> +#define NR_READS_TO_WAIT (5) /* number of times to check if DE = 0 */
>>>
>>>
>>>     Parens not needed. (I'm seeing this patchset for the first time.)
>
>
>> They prevent funny things from happening so I use them all the time.
>
>
>    No, they don't in this case.
>
>> First time when I sent the patch-set, I had missed linux-sh mailing
>> list.
>> Here's the link from dmaengine mailing list in case you're interested
>> http://www.spinics.net/lists/dmaengine/msg06103.html
>
>
>    Thanks for the link.
>
>>>> +static inline int rcar_dmac_wait_stop(struct rcar_dmac_chan *chan)
>>>> +{
>>>> +       unsigned int i = 0;
>>>> +
>>>> +       do {
>>>> +               u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
>>>> +
>>>> +               if (!(chcr & RCAR_DMACHCR_DE))
>>>> +                       return 0;
>>>> +               cpu_relax();
>>>> +               dev_dbg(chan->chan.device->dev, "DMA xfer couldn't be
>>>> stopped");
>>>> +       } while (++i < NR_READS_TO_WAIT);
>>>
>>>
>>>     Hm, this can be a *for* loop, no?
>
>
>> Could you explain why would you prefer a for loop here? do..while
>> makes sure even if NR_READS_TO_WAIT is set to 0, the stop action takes
>> place
>
>
>    Hm, this doesn't make sense to me. If # of reads is 0, we shouldn't read,
> no?
>
>>>   Please don't change the existing indentation, it doesn't seem like
>>> you're changing anything else here
>
>
>> ok. How should I send the updates patch though, through replying to
>> this email or a new thread?
>
>
>    New thread I think.
>
>> Thanks!
>> Hamza
>
>
> MBR, Sergei
>
