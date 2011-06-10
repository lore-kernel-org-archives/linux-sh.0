From: Simon Horman <horms@verge.net.au>
Date: Fri, 10 Jun 2011 06:01:57 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 divide-by-zero FSIDIV fix
Message-Id: <20110610060151.GC22411@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609064913.2219.62039.sendpatchset@t400s>
In-Reply-To: <20110609064913.2219.62039.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 10, 2011 at 01:54:47PM +0900, Magnus Damm wrote:
> On Fri, Jun 10, 2011 at 11:23 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Jun 09, 2011 at 03:49:13PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Update the sh7372 FSIDIV clock code to bail out
> >> with -EINVAL in case of rate is zero.
> >>
> >> Without this fix divide-by-zero is triggering
> >> on sh7372 platforms during system wide resume
> >> of Suspend-to-RAM.
> >
> > Hi Magnus,
> >
> > I'm unsure that I understand how rate ends up being
> > zero in the situation you describe.
> 
> Hi Simon,
> 
> During Suspend-to-RAM resume the function clks_core_resume() in
> drivers/sh/clk/core.c gets executed. This function goes through all
> clocks and sets their rate. In some cases the rate happens to be zero,
> and for the FSIDIV the zero turns into a divide-by-zero.

Ok, understood.
