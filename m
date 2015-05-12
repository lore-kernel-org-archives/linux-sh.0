From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 May 2015 04:15:40 +0000
Subject: Re: [PATCH v2 00/15] r8a7793 SoC, Gose board support
Message-Id: <20150512041540.GB26066@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, May 01, 2015 at 09:49:03AM +0900, Simon Horman wrote:
> On Thu, Apr 30, 2015 at 04:18:49PM +0200, Ulrich Hecht wrote:
> > Hi!
> > 
> > Here is a revised set of patches adding R8A7793 (M2-N) support.
> > The major changes are that I dropped power management for now,
> > and that the PFC monster patch has been broken down for ease
> > of review.  Also a lot of small errors, most spotted by Geert,
> > have been fixed.
> > 
> > CU
> > Uli
> > 
> > 
> > Changes since v1:
> > - pfc: split patch in six
> > - pfc: fixed typos
> > - dts: named clock bits correctly
> > - dts: made more consistent with the very similar r8a7791 dts
> > - dts: removed adv7511, don't know the address
> > - pm: dropped for now, needs to be fixed up first
> > - everywhere: renamed M2N -> M2-N (and M2 to M2-W, while at it)
> > - everywhere: added Acks
> > 
> > 
> > Ulrich Hecht (15):
> >   pinctrl: sh-pfc: Add r8a7793 PFC support part 1: pinmux data
> >   pinctrl: sh-pfc: Add r8a7793 PFC support part 2: pin groups
> >   pinctrl: sh-pfc: Add r8a7793 PFC support part 3: pinmux config
> >     registers
> >   pinctrl: sh-pfc: Add r8a7793 pinmux info
> >   pinctrl: sh-pfc: Enable building of r8a7793 PFC support
> >   pinctrl: sh-pfc: Add renesas,pfc-r8a7793 to binding documentation
> >   ARM: shmobile: Basic r8a7793 SoC support
> >   ARM: shmobile: add r8a7793 SoC device tree
> >   ARM: shmobile: r8a7793: add Gose board device tree
> >   ARM: shmobile: r8a7793: add SMP support
> 
> It looks like in order to have a functional system the shmobile patches
> need at least some of the pinctl patches. Probably the shmobile
> and pinctl patches can be merged in parallel. But regardless I am marking
> the shmobile patches as deffered until the pinctrl patches are accepted.
> 
> FWIW, I think it ought to be possible to supply slimmer DT files that
> allow for a working system without any PFC dependencies. This may allow
> some Gose support to be merged faster.
> 
> >   clk: shmobile: r8a7793: document DIV6 clock bindings
> >   mmc: sh_mmcif: Document r8a7793 DT bindings
> >   serial: sh-sci: Add device tree bindings for r8a7793
> >   clk: shmobile: Add r8a7793 SoC to MSTP bindings
> >   PCI: rcar: document r8a7793 DT bindings

I see that you have reposted the PFC patches as a separate patch-set.
I am entirely supportive of that. And I would like to offer some
suggestions about how we could move some of the shmobile side forward.

My suggestion is to create a patch set which provides basic support and
does not have any dependency on PFC. By basic support I mean serial port,
timer and maybe network if there is no dependency on PFC.

Once basic support has been merged further support can be added in an
incremental manner as the bindings and other driver support becomes ready
(merged).

I am more than happy to offer assistance, please feel free to contact me
privately or on-list.
