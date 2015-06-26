From: Simon Horman <horms@verge.net.au>
Date: Fri, 26 Jun 2015 05:25:08 +0000
Subject: Re: [PATCH v2 00/06] ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2
Message-Id: <20150626052507.GA7703@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150625085716.24543.84444.sendpatchset@little-apple>
In-Reply-To: <20150625085716.24543.84444.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 25, 2015 at 05:57:16PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2
> 
> [PATCH v2 01/06] ARM: shmobile: r8a7779: Configure IRLM mode via DT
> [PATCH v2 02/06] ARM: shmobile: r8a7779: Generic CCF and timer support
> [PATCH v2 03/06] ARM: shmobile: r8a7779: Generic SMP ops
> [PATCH v2 04/06] ARM: shmobile: marzen-reference: Remove C board code
> [PATCH v2 05/06] ARM: shmobile: Remove Marzen from shmobile_defconfig
> [PATCH v2 06/06] ARM: shmobile: r8a7779: Cleanup header file
> 
> Now when "irqchip: renesas-intc-irqpin: r8a7779 IRLM setup support" is
> merged we can continue to cleanup r8a7779 and Marzen.
> 
> With these patches applied the r8a7779 SoC gets DT-only multiplatform
> support and old C board code for multiplatform gets removed.
> 
> The legacy r8a7779 Marzen code is not touched by this series, but
> with these patches applied basic r8a7779 multiplatform SoC support
> is done and only a few I/O devices are legacy-only.
> 
> Only minor changes since V1, fixed build issues for the legacy case.
> Boot tested with shmobile_defconfig on real hardware. Built using
> marzen_defconfig as well but no testing in such case.
> 
> We probably want to figure out a way how to handle kernel configuration
> of regulators...

Shall I queue this up or would you rather wait until some progress
is made on regulators?
