From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 21 May 2008 11:56:07 +0000
Subject: Re: [PATCH 00/03][RFC] Reusable UIO Platform Driver
Message-Id: <aec7e5c30805210456r6f09b1a4sfef5bcefc82f5ba6@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080520105132.1474.73941.sendpatchset@rx1.opensource.se>
	 <20080520210713.GE3220@local>
	 <aec7e5c30805202031x62b3b463lfde0b9e7eb32d35@mail.gmail.com>
	 <20080521064938.GA11580@digi.com>
	 <aec7e5c30805210109p664fd917r32f8dc6aa1c4c746@mail.gmail.com>
	 <20080521092533.GB29607@digi.com>
	 <aec7e5c30805210350l41b537c3n70cfef2e10b54548@mail.gmail.com>
	 <20080521110416.GA10407@digi.com>
In-Reply-To: <20080521110416.GA10407@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Cc: "Hans J. Koch" <hjk@linutronix.de>, linux-kernel@vger.kernel.org, lethal@linux-sh.org, gregkh@suse.de, linux-sh@vger.kernel.org

On Wed, May 21, 2008 at 8:04 PM, Uwe Kleine-K=F6nig
<Uwe.Kleine-Koenig@digi.com> wrote:
> Magnus Damm wrote:
>> What about letting the uio_pdrv code override info->handler and
>> info->enable_irq with the above functions if info->handler is NULL?
> ... if both info->handler and info->prep_read_poll are NULL and
> info->irq >=3D 0.

Even better! =3D)

>> The physically contiguous memory issue still needs to be solved
>> somehow though. What about using struct resouce flagged as
>> IORESOURCE_DMA to pass the amount of memory that should be allocated?
> I'm not sure that solving that problem in uio_pdrv is the right
> approach.  Other uio drivers might have the same problem, so better
> allow the userspace driver to allocate some memory in a more generic
> way?

I don't think there is any generic way for a user space driver to
allocate physically contiguous memory. If such way exists then we
should use that instead of course. Recommendations anyone?

>> Regarding loosing information, if your hardware device can't cope with
>> long latencies and drops things on the floor then improve your
>> latency, increase buffer size or design better hardware. Also, I don't
>> think the interrupt can go berserk since it will be disabled directly
>> by the interrupt handler.
> Assume your irq is stuck at its active level.  Normally the irq is
> then disabled after some time.  You can handle that in your userspace
> driver, but with acking in kernel space and returning IRQ_NONE or
> IRQ_HANDLED you get it for free.  Nevertheless, go on.

Ok, so normally if the irq is stuck as asserted then it gets disabled
after some time. In my case it gets disabled directly so see it as a
feature. =3D)

Would you like to fold in the irq_handler and irq_enable function in
your patch, or would you like me to make a patch that fits on top of
your latest version?

Thanks for your help!

/ magnus
