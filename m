From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 11 Aug 2012 22:29:52 +0000
Subject: Re: [PATCH 14/15] sh: MTU2: Basic runtime PM support
Message-Id: <201208120029.52938.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl> <201208060149.37972.rjw@sisk.pl> <CAMuHMdUFeS6HNFuKVDLrFEo0f5=jrufa4QoD+aeZJHJD1Q1xCQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUFeS6HNFuKVDLrFEo0f5=jrufa4QoD+aeZJHJD1Q1xCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>

On Saturday, August 11, 2012, Geert Uytterhoeven wrote:
> On Mon, Aug 6, 2012 at 1:49 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > @@ -341,8 +346,19 @@ static int __devinit sh_mtu2_probe(struc
> >         if (ret) {
> >                 kfree(p);
> >                 platform_set_drvdata(pdev, NULL);
> > +               pm_runtime_idle(&pdev->dev);
> > +               return ret;
> >         }
> > -       return ret;
> > +       if (is_early_platform_device(pdev))
> > +               return 0;
> > +
> > + out:
> > +       if (cfg->clockevent_rating)
> 
> drivers/clocksource/sh_mtu2.c:356:6: error: 'cfg' undeclared (first
> use in this function)
> http://kisskb.ellerman.id.au/kisskb/buildresult/6883515/
> 
> Presumably there's a
> 
>         struct sh_timer_config *cfg = p->pdev->dev.platform_data;
> 
> missing at the top of sh_mtu2_probe()

Precisely.

It should be fixed now, thanks for the report!

Rafael
