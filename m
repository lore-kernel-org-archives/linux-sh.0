From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 15 Apr 2009 11:23:06 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <20090415112306.GA16961@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 15, 2009 at 08:15:12PM +0900, Magnus Damm wrote:
> On Tue, Mar 31, 2009 at 5:42 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > We need to see hard requirements here, in technical detail, not
> > hand-waving about needing to be flexible for parts and requirements that
> > never materialize. Assembly stubs do work for the vast majority of cases
> > we have today, and the current model fits the CPU/board split pretty
> > well.
> 
> Yes, assembly stubs work fine for the SuperH Mobile sleep modes
> implemented so far. I suspect that upcoming "R-standby mode" will be
> easier to support with an interpreter though. Time will tell.
> 
As long as there are users for it, then we can look at supporting it. The
main thing is that it is supported as an optional method for platforms to
do finer grained support outside of the assembly stubs, and not making it
a requirement for every platform.

> Francesco, if you feel like it and have time available, please
> consider submitting support for some ST cpu/board combination
> upstream. That may make it easier to motivate why an interpreter is
> needed.
> 
If the ST CPUs and boards were upstream then making these sorts of
decisions is a lot easier. As it is now, while we certainly want to
accomodate these CPUs as much as possible, we are likewise not going to
introduce undue burden on in-tree platforms for out-of-tree code,
especially since it gets very difficult to make any changes in-tree
without having any idea what the implications are out-of-tree.

So, I'm willing to entertain an interpreter that satisfies the needs of
in-tree components. If this is to be extended for ST parts, those parts
need to be pushed upstream first. On the other hand, it should be easy to
build on top of whatever trivial interpreter gets integrated, and just
patch on top of that for out-of-tree use if an upstream merge is never
going to happen.
