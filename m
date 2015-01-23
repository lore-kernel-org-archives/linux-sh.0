From: Simon Horman <horms@verge.net.au>
Date: Fri, 23 Jan 2015 04:22:49 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: sh73a0: CCF conversion fallout
Message-Id: <20150123042249.GA17548@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1420574166-14979-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420574166-14979-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 22, 2015 at 11:52:46AM +0900, Simon Horman wrote:
> On Thu, Jan 08, 2015 at 09:07:51AM +0900, Simon Horman wrote:
> > On Tue, Jan 06, 2015 at 08:56:04PM +0100, Geert Uytterhoeven wrote:
> > > 	Hi Simon, Magnus,
> > > 
> > > This patch series contains two missing pieces for the sh73a0 common
> > > clock framework conversion.
> > > 
> > > Both patches are independent of each other, but please note that "ARM:
> > > shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module"
> > > (con)textually depends on "ARM: shmobile: sh73a0 dtsi: Set
> > > control-parent for all irqpin nodes", which is a fix for a crash and
> > > thus had higher priority.
> > > 
> > > Thanks for applying!
> > 
> > Thanks, done.
> 
> For the record: Olof has asked for review comments for the BSC driver and
> binding patches. Accordingly I have dropped them, and these patches which
> depend on them, from next.
> 
> This dependency may be due to the way the branches are arranged, rather
> than actual dependencies of the code. But regardless I am dropping all
> effected branches for now.

I have now had a chance to re-examine these patches and it seems to me that
they do not depend on the BSC driver (or anything else other than for
context). With that in mind I have queued them up in the dt-for-v3.21
branch as part of renesas-devel-20150123-v3.19-rc5.

Please take a moment to see if what I have done makes sense to you.

For reference this covers the following patches which comprised this series:

Geert Uytterhoeven (1):
  ARM: shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module

Ulrich Hecht (1):
  ARM: shmobile: sh73a0 dtsi: Add selectable sources to DIV6 clocks
