From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Jun 2012 19:12:51 +0000
Subject: Re: [PATCH] mmc: tmio: Don't access hardware registers after stopping clocks
Message-Id: <1538938.WjgJgiBpYR@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1339505838-8831-1-git-send-email-laurent.pinchart@ideasonboard.com> <CANqRtoQdzq5VHqBo1WQUYimVAYsGM6+XmE5r1Aoadm_HpY=eMA@mail.gmail.com>
In-Reply-To: <CANqRtoQdzq5VHqBo1WQUYimVAYsGM6+XmE5r1Aoadm_HpY=eMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Magnus,

On Thursday 14 June 2012 20:12:33 Magnus Damm wrote:
> On Tue, Jun 12, 2012 at 9:57 PM, Laurent Pinchart wrote:
> > The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> > width. When the MMC controller gets powered off, runtime PM switches the
> > MSTP clock off. Writing to to CTL_SD_MEM_CARD_OPT register afterwards
> > fails and prints an error message to the kernel log.
> > 
> > As configuring the bus width is pointless when the interface gets
> > powered down, skip the operation when power is off.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> First of all, thanks for reporting this issue and coming up with a fix!

You're welcome. You can expect more of them ;-)

> Can you please explain a bit more about when this triggers? Is this
> related to suspend-to-ram perhaps? Which hardware platform? Is
> CONFIG_PM_RUNTIME=y set?

I've noticed the problem on the Armadillo board with CONFIG_PM_RUNTIME=y. The 
driver spits out "timeout waiting for SD bus idle" error messages more or less 
continuously.

> I suspect that this may be a side effect of the current PM code used
> on the A1 SoC (which is hooked up on the armadillo board).
> 
> In short, the A1 SoC does not yet make use of PM domains, but AP4 and
> the mackerel board (sh7372 based) is using PM domains.

Does this mean that runtime PM is a no-op on A1 ? That would surprise me, as 
turning CONFIG_PM_RUNTIME off gets rid of the problem, so runtime PM is 
somehow involved. Even if the power domain does not get turned off, can't the 
MSTP clock be turned off ?

> This difference may result in different state of clocks at suspend-to-ram
> timing. So the SDHI driver may work just fine on the mackerel board, but not
> on the armadillo board. If that's the case then perhaps we shouldn't fix the
> driver, but instead look at the platform level.

I still believe there's a bug in the driver, please see below.

> > diff --git a/drivers/mmc/host/tmio_mmc_pio.c
> > b/drivers/mmc/host/tmio_mmc_pio.c index 9a7996a..de1226d 100644
> > --- a/drivers/mmc/host/tmio_mmc_pio.c
> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
> > @@ -816,13 +816,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc,
> > struct mmc_ios *ios) tmio_mmc_clk_stop(host);
> >        }
> > 
> > -       switch (ios->bus_width) {
> > -       case MMC_BUS_WIDTH_1:
> > -               sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
> > -       break;
> > -       case MMC_BUS_WIDTH_4:
> > -               sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
> > -       break;
> > +       if (host->power) {
> > +               switch (ios->bus_width) {
> > +               case MMC_BUS_WIDTH_1:
> > +                       sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT,
> > 0x80e0);
> > +               break;
> > +               case MMC_BUS_WIDTH_4:
> > +                       sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT,
> > 0x00e0);
> > +               break;
> > +               }
> >        }
> > 
> >        /* Let things settle. delay taken from winCE driver */
> > --
> > 1.7.3.4
> 
> Is it possible that you get here through tmio_mmc_host_suspend() and
> mmc_suspend_host()?
> 
> Just guessing. =)

I haven't checked the complete call stack, but I don't think it matters that 
much.

What happens here is that the driver tried to write to a 16-bit hardware 
register after calling pm_runtime_put(). At that point runtime PM may have 
turned to power domain and/or the MSTP clock off for the device. Writing to a 
16-bit register first polls for the bus idle bit in the CTL_STATUS2 to be set. 
This never happens in this case (probably because the clock has been turned 
off), so the write operation fails.

Speaking generally, I think we should avoid writing to the device after 
calling pm_runtime_put(), it just doesn't make much sense. If we release the 
device from a PM point of view, it means we don't need to touch it anymore, so 
we should prevent writes until the next pm_runtime_get_sync() call.

-- 
Regards,

Laurent Pinchart

