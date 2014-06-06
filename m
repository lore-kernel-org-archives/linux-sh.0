From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Fri, 06 Jun 2014 20:57:51 +0000
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Message-Id: <3122018.iBNBjMKNbN@vostro.rjw.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
 <20140606125003.GA13332@verge.net.au> <20140606130850.GO2520@sirena.org.uk>
In-Reply-To: <20140606130850.GO2520@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, June 06, 2014 02:08:50 PM Mark Brown wrote:
> 
> --cU9XODsizZBnwgll
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Fri, Jun 06, 2014 at 09:50:06PM +0900, Simon Horman wrote:
> > On Fri, Jun 06, 2014 at 09:14:01PM +0900, Magnus Damm wrote:
> 
> > > I'm not sure about the expected merge order for this kind of change vs
> > > queued up stuff in the renesas git tree, but I believe the following
> > > patch selects ARCH_HAS_OPP:
> 
> > > [PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable
> 
> > I propose that we fix that up by adding an incremental patch to
> > mach-shmobile via my renesas tree once the dependency (assuming there is
> > one) is in Linus's tree.
> 
> Yes, the conversion to make ARCH_HAS_OPP unused is in Raphael's tree for
> the merge window.

Perhaps already merged?

Rafael

