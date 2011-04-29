From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 29 Apr 2011 21:07:34 +0000
Subject: Re: [Update][PATCH 7/9] PM / Runtime: Generic clock manipulation rountines for runtime PM (v3)
Message-Id: <201104292307.35070.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104130205.26988.rjw@sisk.pl> <201104280258.34694.rjw@sisk.pl> <20110429205039.GB7497@ponder.secretlab.ca>
In-Reply-To: <20110429205039.GB7497@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Colin Cross <ccross@google.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Kevin Hilman <khilman@ti.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-sh@vger.kernel.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>

On Friday, April 29, 2011, Grant Likely wrote:
> On Thu, Apr 28, 2011 at 02:58:34AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, April 28, 2011, Colin Cross wrote:
> > > On Wed, Apr 27, 2011 at 2:48 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > +void pm_runtime_clk_remove(struct device *dev, const char *con_id)
> > > > +{
> > > > +       struct pm_runtime_clk_data *prd = __to_prd(dev);
> > > > +       struct pm_clock_entry *ce;
> > > > +
> > > > +       if (!prd)
> > > > +               return;
> > > > +
> > > > +       mutex_lock(&prd->lock);
> > > > +
> > > > +       list_for_each_entry(ce, &prd->clock_list, node)
> > > Braces
> > 
> > No, this is correct as is.
> 
> The code is correct, but Colin's comment is valid.  Braces do make it
> easier for a reader to properly interpret the scope of large multiline
> blocks, even if it does resolve to a single statement.

OK, I'll add the braces.

Thanks,
Rafael
