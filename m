From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 10 Nov 2015 09:48:24 +0000
Subject: RE: [RFC PATCH 0/3] Add PCIe to r8a7795 & Salvator-X
Message-Id: <PS1PR06MB1180D3628481D1DECD3D2E17F5140@PS1PR06MB1180.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On 10 November 2015 02:00, Simon wrote:
> On Mon, Nov 02, 2015 at 05:31:36PM +0000, Phil Edworthy wrote:
> > These patches are needed to get PCIe working on the Salvator-X board, see
> > https://lkml.org/lkml/2015/11/2/445.
> >
> > They depend on the cpg-mssr driver and other patches so are on top of
> > git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
> > renesas-drivers-2015-10-27-v4.3-rc7
> >
> > Phil Edworthy (3):
> >   clk: shmobile: r8a7795: Add PCIe clocks
> >   arm64: renesas: r8a7795: Add PCIe nodes
> >   arm64: dts: r8a7795: enable PCIe on Salvator-X
> >
> >  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 +++++
> >  arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 60
> +++++++++++++++++++++-
> >  drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c        |  2 +
> >  3 files changed, 73 insertions(+), 1 deletion(-)
> 
> In order to facilitate further review and testing I have added
> the two "arm64:" integration patches to a topic branch
> topic/r8a7795-pcie in my renesas tree on kernel.org.
> 
> *** This does not in any way imply that I have queued up these
>     patches for mainline. Please address feedback for the series,
>     as you would for any other series, and repost accordingly.
>     I will likely add any revised series to new topic branches.
> 
> Geert, please consider adding this to renesas-drivers as you see fit.
> 
> The base of the branch is "[PATCH v12 0/7] arm64: renesas: Add Renesas
> R8A7795 SoC support" which can be found in the topic/arm64-rcar-gen3-v12
> branch.
> 
> 
> The above branches only satisfy compile-time dependencies. The resulting
> kernel does not boot. In order to facilitate run-time testing
> I have also provided a topic/r8a7795-pcie.runtime branch.
> The intention is to provide all run-time dependencies. In practice
> I am unsure what they are so instead it provides those necessary
> for a booting system. If you know of more run-time dependencies,
> which are present in subsystem maintainer trees, please let me know.
Sorry, I'm not sure of the process here... The arm64 patches and
the 'clk: shmobile: r8a7795' patch were only posted as RFC to enable
people to test against a branch in Geert's renesas-drivers.git tree.
The other PCIe patches are in pci-next and have already been pulled
by Linus. I would have thought that we should wait until these are in
your branch before trying to add the arm64 patches.

Do you want me to list the commits needed to get PCIe to work on
Salvator-X, or is it ok to just say pci-next plus any others needed?

Thanks
Phil
