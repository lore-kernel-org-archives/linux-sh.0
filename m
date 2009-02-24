From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 Feb 2009 14:12:29 +0000
Subject: Re: INTC issue
Message-Id: <aec7e5c30902240612l4e6b299at8452971f0c951c35@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <498AD5E4.8050809@renesas.com>
In-Reply-To: <498AD5E4.8050809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Tue, Feb 17, 2009 at 3:21 PM, Yoshihiro Shimoda
<shimoda.yoshihiro@renesas.com> wrote:
> Magnus Damm wrote:
>> Please let me know if the patch solves your issue. I'll break out the
>> patch and fix up other processors and post a proper patch set in a
>> little while if this change solves your problem.
>
> When I used this patch and change DMAC driver, my issue was solved!

Excellent!

> But I think that I might as well change DMAC only. For example, when SCIF
> driver get same interrupt number, SCIF driver use sci_mpxed_interrupt().
> Because this function check interrupt flag, overheads increase just a lit=
tle.

I agree that the overhead is increased a bit, but 100% working
interrupt masking is more important than performance. This only
affects some processor types though, so hopefully future processors
allow us to mask interrupts in a more fine-grained fashion. For
instance, SuperH Mobile devices such as sh7722 and sh7723 does not
require any fixes like this. =3D)

Also, regarding performance, out cache footprint becomes slightly
smaller with a single interrupt for multiple vectors. That may
compensate a bit for the added overhead.

> The DMAC driver changes:
> =A0- fix register maps for SH7785. :)
> =A0- change DMAC irq number.
> =A0- add IRQF_SHARED flag of request_irq().
> =A0- add dummy args of request_irq() in sh_dmac_init().

Cool. If you want to use a single interrupt but keep the overhead to a
minimum I recommend a change similar to my recent sh-rtc patch. It is
using a single shared interrupt handler - like the
sci_mpxed_interrupt(). I think such a strategy may be more efficient
than using multiple shared interrupt handlers.

Thanks for your help!

/ magnus
