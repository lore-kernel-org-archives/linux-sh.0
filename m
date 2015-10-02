From: Simon Horman <horms@verge.net.au>
Date: Fri, 02 Oct 2015 07:24:25 +0000
Subject: Re: [PATCH v10 00/07] Renesas R-Car H3 (r8a7795) integration patches V10
Message-Id: <20151002072423.GA15552@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151002025509.28158.23176.sendpatchset@little-apple>
In-Reply-To: <20151002025509.28158.23176.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

I have pushed these patches to the renesas tree in a topic branch as
described below.

To be quite clear none of these patches are queued up for mainline yet and
as such they are not included in the next or devel branches of the renesas
tree.

On Fri, Oct 02, 2015 at 11:55:09AM +0900, Magnus Damm wrote:
> Renesas R-Car H3 (r8a7795) integration patches V10
> 
> [PATCH v10 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
> [PATCH v10 02/07] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
> [PATCH v10 03/07] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
> [PATCH v10 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
> [PATCH v10 05/07] arm64: renesas: r8a7795: enable PFC
> [PATCH v10 06/07] arm64: renesas: add Salvator-X board support on DTS
> [PATCH v10 07/07] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC
> 
> This is V10 of the R-Car H3 SoC support which contains a simplified
> series of initial r8a7795 support including:
> - Single CPU core, Arch timer, GIC
> - CPG and MSTP
> - r8a7795 SCIF0->SCIF6
> - PFC
> - Salvator-X DEBUG0 and DEBUG1 serial ports.
> 
> Compared to V9 this V10 series is updated in a couple of ways:
> - [RFC] is dropped since PFC DT is stable and CPG DT at least semi-stable
> - For CCF the DT property clock-output-names is now included - thanks Geert!
> - SCIF ports are updated to include DMAC and depend on MSSR in Patch 4/7
> - Fixes for PLL1 and EXTAL are folded in
> 
> Regarding dependencies, for build time there are no special dependencies.
> As for runtime this V10 integration series depends on the following:

I have pushed this series to a new topic/arm64-rcar-gen3-v10 branch
which is based on v4.3-rc1.
