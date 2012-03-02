From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 02 Mar 2012 20:50:39 +0000
Subject: Re: [PATCH 00/06] ARM: mach-shmobile: map_io and init_early update
Message-Id: <201203022150.39942.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120229123656.28584.90874.sendpatchset@w520>
In-Reply-To: <20120229123656.28584.90874.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday, March 02, 2012, Paul Mundt wrote:
> On Thu, Mar 01, 2012 at 10:22:03PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 29, 2012, Magnus Damm wrote:
> > >  ARM: mach-shmobile: map_io and init_early update
> > > 
> > > [PATCH 01/06] ARM: mach-shmobile: sh7367 map_io and init_early update
> > > [PATCH 02/06] ARM: mach-shmobile: sh7377 map_io and init_early update
> > > [PATCH 03/06] ARM: mach-shmobile: sh7372 map_io and init_early update
> > > [PATCH 04/06] ARM: mach-shmobile: sh73a0 map_io and init_early update
> > > [PATCH 05/06] ARM: mach-shmobile: r8a7740 map_io and init_early update
> > > [PATCH 06/06] ARM: mach-shmobile: r8a7779 map_io and init_early update
> > > 
> > > This patch series converts the mach-shmobile subarch to properly
> > > make use of a per-soc map_io and a separate init_early callback for
> > > early serial console support on platforms where that is possible.
> > > 
> > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > 
> > Paul, would you mind if I took this patchset into the renesas tree for v3.4?
> 
> On Thu, Mar 01, 2012 at 10:21:14PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 29, 2012, Magnus Damm wrote:
> > > From: Magnus Damm <damm@opensource.se>
> > > 
> > > Rename clk_init() to shmobile_clk_init() to avoid a potential
> > > future name space collision with the common clock framework.
> > > 
> > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > 
> > Paul, would you mind if I took this patchset into the renesas tree for v3.4?
> 
> Both look fine to me, so feel free to take them at your leisure.

I will, thanks!
