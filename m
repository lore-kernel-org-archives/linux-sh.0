From: Simon Horman <horms@verge.net.au>
Date: Fri, 04 Sep 2015 01:14:07 +0000
Subject: Re: [PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9
Message-Id: <20150904011406.GB5869@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150903103217.26791.32559.sendpatchset@little-apple>
In-Reply-To: <20150903103217.26791.32559.sendpatchset@little-apple>
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

On Thu, Sep 03, 2015 at 07:32:17PM +0900, Magnus Damm wrote:
> Renesas R-Car H3 (r8a7795) integration patches V9
> 
> [PATCH v9 01/07][RFC] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
> [PATCH v9 02/07][RFC] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
> [PATCH v9 03/07][RFC] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
> [PATCH v9 04/07][RFC] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
> [PATCH v9 05/07][RFC] arm64: renesas: r8a7795: enable PFC
> [PATCH v9 06/07][RFC] arm64: renesas: add Salvator-X board support on DTS
> [PATCH v9 07/07][RFC] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC
> 
> This is V9 of the R-Car H3 SoC support which contains a simplified
> series of initial r8a7795 support including:
> - Single CPU core, Arch timer, GIC
> - CPG and MSTP
> - r8a7795 SCIF0->SCIF6
> - PFC
> - Salvator-X DEBUG0 and DEBUG1 serial ports.
> 
> At this point this series is not considered as stable enough for upstream
> merge so in V9 I've added [RFC] to the patches. . The quality of the
> patches and the system performance seems stable enough to me, but the
> patch series below for CPG, PFC and SCIF are not yet included in -next
> so until the DT bindings have been agreed on this series will be kept
> at [RFC] state.

Thanks for the "[RFC]" prefix, it is much appreciated.

> Regarding dependencies, for build time there are no special dependencies.
> As for runtime this V9 integration series depends on the following:
> 
> CPG:
> [PATCH v6 00/05] Renesas R-Car Gen3 CPG support V6
> 
> PFC:
> [PATCH 0/9 v2] sh-pfc: modify PINMUX_IPSR_MSEL() and r8a7795 support
> 
> SCIF:
> [PATCH] serial: sh-sci: Add device tree support for r8a7795

I have pushed this series to a new topic/arm64-rcar-gen3-v9 branch.

I have based it on the same base used for v8, it is described below.
It is a merge of:
* The next/arm64 branch of the arm-soc tree[1],
  which is in turn based on is v4.2-rc2.
* The next/soc branch of the arm-soc tree [2],
  which is also based on v4.2-rc2.

The reason for including next/arm64 in the base is that there were several
patches in arm-soc required to apply the patchset cleanly. In particular
eed6b3eb20b9 ("arm64: Split out platform options to separate Kconfig")
which adds arch/arm64/Kconfig.platforms.

The reason for including next/soc in the base is that it appears to
be needed for next/arm64 to compile with the arm64 defconfig.
In particular
c84e358718a6 ("soc: Mediatek: Add SCPSYS power domain driver")
appears to be required by
c02e0e86d304 ("arm64: dts: mt8173: Add afe device node").

As the dependencies you mention above are run-time rather than
build-time I have not included them in the topic branch.

[1] Head commit:
    bcfff4d961fb ("arm64: Enable Marvell Berlin SoC family in def config")
[2] Head commit:
    341a670abd1c ("ARM64: dts: vexpress: Use assigned-clock-parents for
    sp810")
