From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 02 Mar 2013 20:07:32 +0000
Subject: Re: [PATCH] gpio: em: Add Device Tree support
Message-Id: <20130302200732.E18BB3E206B@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <20130226132623.18365.36583.sendpatchset@w520> <20130226224106.GC20670@core.coreip.homeip.net> <CANqRtoRUqDsspHQQ11d3c2jc+MvoROwfbv3so5=SGhHOs9k7WA@mail.gmail.com> <20130228051122.GA12312@verge.net.au>
In-Reply-To: <20130228051122.GA12312@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-sh@vger.kernel.org

On Thu, 28 Feb 2013 14:11:23 +0900, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Feb 27, 2013 at 07:13:46PM +0900, Magnus Damm wrote:
> > Hi Dmitry,
> > 
> > Thanks for your feedback!
> > 
> > On Wed, Feb 27, 2013 at 7:41 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > Hi Magnus,
> > >
> > > On Tue, Feb 26, 2013 at 10:26:23PM +0900, Magnus Damm wrote:
> > >> From: Magnus Damm <damm@opensource.se>
> > >>
> > >> Update the Emma Mobile GPIO driver to add DT support.
> > >>
> > >
> > > ...
> > >
> > >> @@ -366,15 +387,33 @@ static int em_gio_remove(struct platform
> > >>       return 0;
> > >>  }
> > >>
> > >
> > > #ifdef CONFIG_OF here? No need to have extra aliases in modules if OF
> > > support is not enabled (or is entire ARM arch now enables device tree?).
> > >
> > >> +static const struct of_device_id em_gio_dt_ids[] = {
> > >> +     { .compatible = "renesas,em-gio", },
> > >> +     {},
> > >> +};
> > >> +MODULE_DEVICE_TABLE(of, em_gio_dt_ids);
> > >> +
> > 
> > I suppose we could sprinkle a couple of #ifdefs across the code, but I
> > have to say that I'm not that fond of #ifdefs in general. So if it was
> > up to me only then I would aim at having exactly zero #ifdefs in my
> > drivers at the expense of slightly larger binaries in some cases.
> 
> My take on this is as follows (if anyone cares):
> 
> * The driver in question is currently only useful in conjunction with
>   the Emev2 SoC and the kzm9g board which uses that SoC. The current
>   (and to date only) practice when booting that board and thus SoC
>   with merged upstream code is to do so using DT.
> 
> * The inclusion of the code above does not appear to cause build-time
>   breakage even if CONFIG_OF is not set.
> 
> So it seems to me that it is reasonable to leave the code as is
> without being guarded by an #ifdef.

I completely agree.  Applied for v3.10

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
