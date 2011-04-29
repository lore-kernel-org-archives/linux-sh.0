From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 29 Apr 2011 20:50:39 +0000
Subject: Re: [Update][PATCH 7/9] PM / Runtime: Generic clock manipulation
Message-Id: <20110429205039.GB7497@ponder.secretlab.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <201104130205.26988.rjw@sisk.pl>
 <201104272348.24084.rjw@sisk.pl>
 <BANLkTimHkKq9+0z-4CZs=34GNO6Ab0wZPQ@mail.gmail.com>
 <201104280258.34694.rjw@sisk.pl>
In-Reply-To: <201104280258.34694.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Colin Cross <ccross@google.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@ti.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-sh@vger.kernel.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>

On Thu, Apr 28, 2011 at 02:58:34AM +0200, Rafael J. Wysocki wrote:
> On Thursday, April 28, 2011, Colin Cross wrote:
> > On Wed, Apr 27, 2011 at 2:48 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > +void pm_runtime_clk_remove(struct device *dev, const char *con_id)
> > > +{
> > > +       struct pm_runtime_clk_data *prd = __to_prd(dev);
> > > +       struct pm_clock_entry *ce;
> > > +
> > > +       if (!prd)
> > > +               return;
> > > +
> > > +       mutex_lock(&prd->lock);
> > > +
> > > +       list_for_each_entry(ce, &prd->clock_list, node)
> > Braces
> 
> No, this is correct as is.

The code is correct, but Colin's comment is valid.  Braces do make it
easier for a reader to properly interpret the scope of large multiline
blocks, even if it does resolve to a single statement.

g.

> 
> > > +               if (!con_id && !ce->con_id) {
> > > +                       __pm_runtime_clk_remove(ce);
> > > +                       break;
> > > +               } else if (!con_id || !ce->con_id) {
> > > +                       continue;
> > > +               } else if (!strcmp(con_id, ce->con_id)) {
> > > +                       __pm_runtime_clk_remove(ce);
> > > +                       break;
> > > +               }
> > > +
> > > +       mutex_unlock(&prd->lock);
> > > +}
