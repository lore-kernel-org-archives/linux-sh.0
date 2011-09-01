From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 01 Sep 2011 22:11:12 +0000
Subject: Re: [RFC][PATCH 5/5] PM / Domains: Add default power off governor function
Message-Id: <201109020011.12264.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl> <201108310022.43850.rjw@sisk.pl> <CAORVsuW7rFEN8u7RCpmWJamtG2iUbA_zz3ax4hgBjGAZW9vU=A@mail.gmail.com>
In-Reply-To: <CAORVsuW7rFEN8u7RCpmWJamtG2iUbA_zz3ax4hgBjGAZW9vU=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>

Hi,

On Thursday, September 01, 2011, Jean Pihet wrote:
> Rafael,
> 
> On Wed, Aug 31, 2011 at 12:22 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Add a function deciding whether or not a given PM domain should
> > be powered off on the basis of that domain's devices' PM QoS
> > constraints.
> >
> > ---
> >  drivers/base/power/domain_governor.c |   96 +++++++++++++++++++++++++++++++++++
> >  include/linux/pm_domain.h            |    7 ++
> >  2 files changed, 103 insertions(+)
> >
> > Index: linux/include/linux/pm_domain.h
> > =================================> > --- linux.orig/include/linux/pm_domain.h
> > +++ linux/include/linux/pm_domain.h
> > @@ -49,6 +49,10 @@ struct generic_pm_domain {
> >        int (*start_device)(struct device *dev);
> >        int (*stop_device)(struct device *dev);
> >        bool (*active_wakeup)(struct device *dev);
> > +       ktime_t power_off_latency;
> > +       ktime_t power_on_latency;
> > +       s64 break_even_ns;
> > +       s64 min_delta_ns;
> How are those values populated?

I'm not sure.  There are a few possible ways to do that, but I simply
don't know which one is going to be the most useful.  That's one of
the reasons why patches [4-5/5] are RFCs.

> Is there a mechanism that dynamically updates the values?

Obviously not at the moment.

Thanks,
Rafael
