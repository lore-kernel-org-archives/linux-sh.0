From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Jun 2012 23:14:19 +0000
Subject: Re: [PATCH 1/2] irqdomain: Fix up linear revmap for non-zero hwirq displacement.
Message-Id: <20120615231419.GC7357@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1339572841-26175-1-git-send-email-lethal@linux-sh.org>
 <20120615182540.489133E0ACE@localhost>
In-Reply-To: <20120615182540.489133E0ACE@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 15, 2012 at 12:25:40PM -0600, Grant Likely wrote:
> On Wed, 13 Jun 2012 16:34:00 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
> > Presently the linear revmap code assumes that all hwirqs start at 0,
> > using the hwirq directly as an index value for the lookup. In the case of
> > legacy revmaps this isn't necessarily the case, as the first_hwirq value
> > passed in can be non-zero, causing those types of users to silently have
> > their IRQs placed in the radix tree instead.
> > 
> > With this change, hwirq displacement is factored in at association time
> > directly. This also makes it possible for non-legacy users to use linear
> > revmaps regardless of hwirq base position. This could potentially lead to
> > a bug if there's an attempt to associate multiple times in to the linear
> > map in a nonsensical and non-linear order, but at that point being
> > silently punted to the radix tree is likely to be the least of your
> > concerns (in such a case it's fairly trivial to simply extend
> > irq_domain_add_linear() to take a hwirq base and move the linear base
> > assignment there).
> 
> I actually hoped to be rid of the whole hwirq start offset thing.
> Doing without it simplifies the code, is slightly faster.  I suspect
> very few controllers actually need it, and for those that do I'm
> hoping the wasted space is in the order of 0-32 words.
> 
> Instead of this, can we change the affected controllers to use the
> maximum hwirq number when setting the size of the linear map?
> 
> Do you have hardware where the first hwirq is a >32 number?
> 
Yes. On the CPU I was just working on I have two linear ranges and a
tree, one of the linear ranges begins at hwirq 56. On other CPUs we have
linear ranges that begin at 64, 72, etc. most of which are fairly low in
the space. On newer parts on the ARM side there are also controllers with
ranges that begin > 400.

I don't particularly care for the linear_start hack myself either, but I
couldn't think of any cleaner approach for it. The simplest might be if
we can just bury these details in a domain-specific canonicalization op
(distinctly different from xlate), and plug it in for the few cases that
need a non-zero hwirq base. I don't mind hacking that up if you're more
agreeable to that approach.
