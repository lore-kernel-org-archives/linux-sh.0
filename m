From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 25 Feb 2009 04:11:40 +0000
Subject: Re: INTC issue
Message-Id: <49A4C4FC.4090408@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <498AD5E4.8050809@renesas.com>
In-Reply-To: <498AD5E4.8050809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san,

Magnus Damm wrote:
> I agree that the overhead is increased a bit, but 100% working
> interrupt masking is more important than performance. This only
> affects some processor types though, so hopefully future processors
> allow us to mask interrupts in a more fine-grained fashion. For
> instance, SuperH Mobile devices such as sh7722 and sh7723 does not
> require any fixes like this. =)

I think so too. :)

> Also, regarding performance, out cache footprint becomes slightly
> smaller with a single interrupt for multiple vectors. That may
> compensate a bit for the added overhead.

I see! I did not think of cache.

> Cool. If you want to use a single interrupt but keep the overhead to a
> minimum I recommend a change similar to my recent sh-rtc patch. It is
> using a single shared interrupt handler - like the
> sci_mpxed_interrupt(). I think such a strategy may be more efficient
> than using multiple shared interrupt handlers.

I refer to your sh-rtc patch and I will modify DMAC driver.

Thank you very much for your help!

Thanks,
Yoshihiro Shimoda

