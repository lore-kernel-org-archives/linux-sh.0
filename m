From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Nov 2015 02:24:22 +0000
Subject: Re: [RFC PATCH 0/3] Add PCIe to r8a7795 & Salvator-X
Message-Id: <20151126022422.GC30297@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 25, 2015 at 08:57:26AM +0000, Phil Edworthy wrote:
> Hi Simon,
> 
> On 25 November 2015 00:39, Simon Horman wrote:
> > On Wed, Nov 11, 2015 at 04:24:13PM +0000, Phil Edworthy wrote:
> > > Hi Simon,
> > >
> > > On 11 November 2015 15:00, Phil wrote:
> > > > On 11 November 2015 02:51, Simon wrote:
> > > > > On Tue, Nov 10, 2015 at 09:48:24AM +0000, Phil Edworthy wrote:
> > > > > > Hi Simon,
> > > > > >
> > > > > > On 10 November 2015 02:00, Simon wrote:
> > > > > > > On Mon, Nov 02, 2015 at 05:31:36PM +0000, Phil Edworthy wrote:
> > > > > > > > These patches are needed to get PCIe working on the Salvator-X
> > board,
> > > > see
> > > > > > > > https://lkml.org/lkml/2015/11/2/445.
> > > > > > > >
> > > > > > > > They depend on the cpg-mssr driver and other patches so are on top
> > of
> > > > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-
> > drivers.git
> > > > > > > > renesas-drivers-2015-10-27-v4.3-rc7
> > > > > > > >
> > > > > > > > Phil Edworthy (3):
> > > > > > > >   clk: shmobile: r8a7795: Add PCIe clocks
> > > > > > > >   arm64: renesas: r8a7795: Add PCIe nodes
> > > > > > > >   arm64: dts: r8a7795: enable PCIe on Salvator-X
> > > > > > > >
> > > > > > > >  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 +++++
> > > > > > > >  arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 60
> > > > > > > +++++++++++++++++++++-
> > > > > > > >  drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c        |  2 +
> > > > > > > >  3 files changed, 73 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > In order to facilitate further review and testing I have added
> > > > > > > the two "arm64:" integration patches to a topic branch
> > > > > > > topic/r8a7795-pcie in my renesas tree on kernel.org.
> > > > > > >
> > > > > > > *** This does not in any way imply that I have queued up these
> > > > > > >     patches for mainline. Please address feedback for the series,
> > > > > > >     as you would for any other series, and repost accordingly.
> > > > > > >     I will likely add any revised series to new topic branches.
> > > > > > >
> > > > > > > Geert, please consider adding this to renesas-drivers as you see fit.
> > > > > > >
> > > > > > > The base of the branch is "[PATCH v12 0/7] arm64: renesas: Add Renesas
> > > > > > > R8A7795 SoC support" which can be found in the topic/arm64-rcar-gen3-
> > v12
> > > > > > > branch.
> > > > > > >
> > > > > > >
> > > > > > > The above branches only satisfy compile-time dependencies. The
> > resulting
> > > > > > > kernel does not boot. In order to facilitate run-time testing
> > > > > > > I have also provided a topic/r8a7795-pcie.runtime branch.
> > > > > > > The intention is to provide all run-time dependencies. In practice
> > > > > > > I am unsure what they are so instead it provides those necessary
> > > > > > > for a booting system. If you know of more run-time dependencies,
> > > > > > > which are present in subsystem maintainer trees, please let me know.
> > > > > > Sorry, I'm not sure of the process here... The arm64 patches and
> > > > > > the 'clk: shmobile: r8a7795' patch were only posted as RFC to enable
> > > > > > people to test against a branch in Geert's renesas-drivers.git tree.
> > > > > > The other PCIe patches are in pci-next and have already been pulled
> > > > > > by Linus. I would have thought that we should wait until these are in
> > > > > > your branch before trying to add the arm64 patches.
> > > > >
> > > > > I agree entirely that we need to wait before queuing up the arm64 patches
> > > > > for mainline.
> > > > >
> > > > > The purpose of the "topic/" branches is to provide a mechanism for
> > > > > people to make use of the patches before that happens. With the
> > possibility
> > > > > of Geert including the branch in the topic/gen3-latest branch of
> > > > > renesas-drivers, which is again intended to allow people to use patches
> > > > > before they are ready to be queued up for mainline. I believe this
> > > > > is in keeping with your intention when posting these patches.
> > > > Ok, understood!
> > > >
> > > > > > Do you want me to list the commits needed to get PCIe to work on
> > > > > > Salvator-X, or is it ok to just say pci-next plus any others needed?
> > > > >
> > > > > I think the latter would be fine.
> > > > I took topic/r8a7795-pcie.runtime branch and merged pci-next.
> > > >
> > > > On top of this you need this series:
> > > > [PATCH 0/3] Fix rcar-pcie for arm64
> > > > consisting of:
> > > > v2 of PCI: pcie-rcar: Convert to DT resource parsing API
> > > > https://lkml.org/lkml/2015/11/9/196
> > > > Revert "PCI: rcar: Build pcie-rcar.c only on ARM"
> > > > http://permalink.gmane.org/gmane.linux.kernel/2076234
> > > > PCI: pcie-rcar: Add support for R-Car H3.
> > > > http://permalink.gmane.org/gmane.linux.drivers.devicetree/142516
> > > >
> > > > Also need:
> > > > PCI: pcie-rcar: Fix OF node passed to MSI irq domain
> > > > http://permalink.gmane.org/gmane.linux.ports.sh.devel/50280
> > > >
> > > > You also need to add the pcie clocks. This is basically the same as
> > > > [PATCH 1/3] clk: shmobile: r8a7795: Add PCIe clocks
> > > > http://permalink.gmane.org/gmane.linux.ports.sh.devel/50272
> > > > but with the correction that Geert identified and different style
> > > > in the version of the driver in this branch (i.e. uses DEF_MOD)
> > > >
> > > > Using this I was able to use a NFS mounted rootfs via a PCIe
> > > > Ethernet card. Let me know if you would like me to put these on
> > > > a branch somewhere for you.
> > >
> > > I've put it here: https://github.com/pedwo/linux.git in the
> > > phil/renesas/topic/r8a7795-pcie.runtime branch.
> > 
> > Thanks.
> > 
> > What are your feelings regarding queueing up these changes for v4.5,
> > possibly after reposting them?
> You are referring to the dts changes, right? I don't think there is anything
> controversial other than your comment about not using named irqs.

I was referring to the dts and dtsi changes.
I think we could queue them up once the bindings they use
have been accepted e.g. into linux-next.

> > How many of the above mentioned dependencies are present in Linus's tree
> > or otherwise destined for v4.5?
> The "PCI: pcie-rcar: Fix OF node passed to MSI irq domain" patch simply side
> stepped the real problem. Now that Marc Zyngier has posted a proper fix for
> this MSI issue and it's been acked by Thomas Gleixner I am pretty sure that
> will be in v4.5.
> As for the 3 R-Car PCIe driver patches, I can't see why they won't be in v4.5
> but I've not heard anything from Bjorn either...
