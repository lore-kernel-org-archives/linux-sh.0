From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 09 Nov 2011 23:58:12 +0000
Subject: Re: [PATCH] don't skip debugging output upon earlier loop termination
Message-Id: <201111100058.12902.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoQ6YPdQ=z7B8tSnLdf1qn8HbLhQiNc=VTDU7=8CkuBLyw@mail.gmail.com>
In-Reply-To: <CANqRtoQ6YPdQ=z7B8tSnLdf1qn8HbLhQiNc=VTDU7=8CkuBLyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, November 09, 2011, Magnus Damm wrote:
> On Wed, Nov 9, 2011 at 3:44 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > This is against the sh7372-test branch of the linux-pm tree. Feel free to
> > roll this patch into the respective original commit.
> >
> > diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
> > index 46ee116..a81d8a9 100644
> > --- a/arch/arm/mach-shmobile/pm-sh7372.c
> > +++ b/arch/arm/mach-shmobile/pm-sh7372.c
> > @@ -123,13 +123,13 @@ static int pd_power_up(struct generic_pm_domain *genpd)
> >
> >        for (retry_count = 2 * PSTR_RETRIES; retry_count; retry_count--) {
> >                if (!(__raw_readl(SWUCR) & mask))
> > -                       goto out;
> > +                       break;
> >                if (retry_count > PSTR_RETRIES)
> >                        udelay(PSTR_DELAY_US);
> >                else
> >                        cpu_relax();
> >        }
> > -       if (__raw_readl(SWUCR) & mask)
> > +       if (!retry_count)
> >                ret = -EIO;
> >
> >        if (!sh7372_pd->no_debug)
> >
> 
> Hi Guennadi,
> 
> This looks fine to me. In the future, please remember to CC the
> linux-sh list for SoC-specific patches.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Applied to linux-pm/pm-fixes.

Thanks,
Rafael
