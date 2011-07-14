From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 14 Jul 2011 19:34:40 +0000
Subject: Re: [PATCH 0/3] PM / Domains / shmobile fixes
Message-Id: <201107142134.40432.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201107132352.59801.rjw@sisk.pl> <CANqRtoTLO=DqehwanGdE+rgxL_ofa5YCJjsx47doHzwZDP4Ocw@mail.gmail.com>
In-Reply-To: <CANqRtoTLO=DqehwanGdE+rgxL_ofa5YCJjsx47doHzwZDP4Ocw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Thursday, July 14, 2011, Magnus Damm wrote:
> On Thu, Jul 14, 2011 at 6:52 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > The following three patches fix a couple of issues in the code currently
> > in my pm-domains branch at:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains
> >
> > [1/3] - Use genpd_queue_power_off_work() for queuing up the powering off
> >        of A4LC (this avoids attempting to queue up a work item while it is
> >        pending).
> >
> > [2/3] - Make the generic PM domains code react to -EBUSY returned from a
> >        PM domain's .power_down() callback (needed for [3/3]).
> >
> > [3/3] - Return -EBUSY from the A4LC's .power_down() callback to indicate that
> >        the domain hasn't been powered down on purpose and remove the confusing
> >        (and now redundant) pm_genpd_poweron(A4LC) from pd_power_down_a3rv().
> 
> All patches above look great, thanks a lot for your help!
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks!

Rafael
