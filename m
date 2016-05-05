From: Martin Townsend <mtownsend1973@gmail.com>
Date: Thu, 05 May 2016 12:51:36 +0000
Subject: Re: SH7760 IRL Interrupt level 15 not working for SMSC 91C111
Message-Id: <CABatt_yC_OnWfOcZCH3vs00y83wL_5TfL7dPeh7YwPAFnx+-uA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CABatt_yELUqBkEC+RDz0u=r=BR1XbjDbj5bC9ccJGtJyjX7Lqw@mail.gmail.com>
In-Reply-To: <CABatt_yELUqBkEC+RDz0u=r=BR1XbjDbj5bC9ccJGtJyjX7Lqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I think I have it working now, I needed to register an interrupt
controller just for the IRL external interrupts.

Sorry for the noise.

Many Thanks,
Martin.

On Thu, May 5, 2016 at 11:36 AM, Martin Townsend
<mtownsend1973@gmail.com> wrote:
> Hi,
>
> I'm trying to get the interrupt working for the LAN91C111 on our
> board.  It has a SH7760 core and the documentation says the interrupt
> is using IRL code of 15 (the highest priority).  The SH7760 HW manual
> states that this is an INTEVT code of H'200.  In my board support
> source file I'm using the following:
>
> /*
>  * SMSC LAN91C111 Ethernet Platform Data
>  */
> static struct smc91x_platdata smc91x_info = {
>     .flags = SMC91X_USE_16BIT | IORESOURCE_IRQ_LOWLEVEL,
> };
>
> static struct resource smc91x_resources[] = {
>     DEFINE_RES_MEM_NAMED(HICONECT_ETHERNET_BASE, HICONECT_ETHERNET_IOLEN,
>                  "smc91x-memory"),
>     DEFINE_RES_IRQ_NAMED(evt2irq(0x200), "smc91x-irq"),
> };
>
> static struct platform_device smc91x_device = {
>     .name        = "smc91x",
>     .id        = -1,
>     .num_resources    = ARRAY_SIZE(smc91x_resources),
>     .resource    = smc91x_resources,
>
>     .dev = {
>         .platform_data    = &smc91x_info,
>     },
> };
>
> I've enabled the SMSC91x Ethernet Driver but it always fails to request the IRQ.
> I see that the evt2irq(0x200) gives me an IRQ number of 0 which makes
> sense as the IRL0 to IRL3 will all be 0 for IRL interrupt priority 15.
> The SMSC91x driver fails if the irq number is 0 so I fixed this
>
> //    if (ndev->irq <= 0) {
>     if (ndev->irq < 0) {
>         printk(KERN_ERR "[%s]: platform_get_irq failed %d\n",
>             CARDNAME, ndev->irq);
>         ret = -ENODEV;
>         goto out_release_io;
>     }
> but I get a null pointer exception on the following line in the driver
> irq_get_irq_data(ndev->irq)
> so it looks like there is no IRQ desc setup for 0 and looking back in
> the log I see (I've added my own debug to see what IRQ desc are being
> inserted.
>
[snip]
>
> Is there something I should be doing to get IRL level encoded
> interrupts working for SH7760?  I'm using a 4.1 Kernel.
>
> Many Thanks,
> Martin.
