From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 May 2011 12:21:37 +0000
Subject: Re: [PATCH 1/2] mmc: tmio: Allow SDHI MMC to use multiple IRQ vectors
Message-Id: <BANLkTimgok9AfdoxND24Msh8qoRDitMXQA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1303890238-8372-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1303890238-8372-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hey Simon,

On Mon, May 2, 2011 at 8:16 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, May 02, 2011 at 10:55:22AM +0200, Guennadi Liakhovetski wrote:
>> On Wed, 27 Apr 2011, Simon Horman wrote:
>>
>> > SDHI blocks may have up to 4 IRQ vectors.
>> > The first three are of use to us, the 4th one
>> > relates to DRM features that I don't have documentation
>> > for and are almost certainly tainted by licensing issues.
>> >
>> > This patch allows multiple vectors to be used if supplied
>> > in the platform data. Which will allow IRQ multiplexing hacks
>> > to be removed.
>> >
>> > I plan to do further work to split tmio_mmc_irq() into per-vector
>> > handlers. But this patch should be useful by itself.
>>
>> I have one nitpick: using a constant like "3" at multiple locations makes
>> code less future-proof. I would use a macro like TMIO_MMC_MAX_IRQS, at
>> some locations you can also do ARRAY_SIZE(host->irq).
>
> Good thinking, I'll fix that up.
>
>> Also, are we sure,
>> that only "1 IRQ" or "max IRQs" (currently 3) are valid? Can there not be
>> a valid configuration with 2 IRQs? Don't we have such controllers on some
>> SoCs? For example, ap4 SDHI0 and SDHI2 have 4 IRQ vectors, but SDHI1 only
>> 3... But ok, no, I don't see any controllers with < 3 IRQs, so, should
>> work for now.
>
> As far as I know there are currently controllers with 1, 3 and 4 IRQs.
> But in the case of controllers with 4 IRQs we can treat this as 3,
> as the 4th IRQ has some secret IP sauce that I believe we are best to
> say away from.
>
> So handling 1 and 3 IRQs is sufficient to deal with all controllers that
> I am aware of. If there are other combinations that need to be handled
> the obviously my code will need to be extended accordingly.
>
> I think the easiest way to support other numbers of IRQs would be to probe
> up to TMIO_MMC_MAX_IRQS, And then either record how many we found in a new
> element of tmio_mmc_host, or make the irq[] element terminated by a
> negative value.
>
> I can change the code around to do that, though I think that
> I prefer the current approach given the hardware that I am aware of.

In the future I imagine we may want to associate different interrupt
handler functions to each interrupt source, so from that point of view
it may make sense to move the request_irq() out from
tmio_mmc_host_probe() into sh_mobile_sdhi_probe() and
tmio_mmc_probe(). Same thing with the free_irq() implementation in
xxx_remove(). I guess tmio_mmc_irq() needs to be global and use
EXPORT_SYMBOL() for such a break out.

If we break out the IRQ part of the code we can also easily modify the
SDHI code to get rid of the IRQF_TRIGGER_FALLING flag that isn't
working on GIC-enabled platforms like AG5. Such a break out would also
remove the need for any array of interrupts and TMIO_MMC_MAX_IRQS.

There may be some side effects of the suggestion above though, but anyway...

Thanks,

/ magnus
