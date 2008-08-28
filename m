From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Aug 2008 06:41:29 +0000
Subject: Re: [PATCH] sh: crash kernel resource fix
Message-Id: <20080828064128.GA21623@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080827091543.9100.82819.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080827091543.9100.82819.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 27, 2008 at 06:15:43PM +0900, Magnus Damm wrote:
> The reserved crash kernel memory range is currently missing from
> /proc/iomem. crashk_res is mistakenly setup after __add_active_range().
> Reorder things to make sure the resource shows up in /proc/iomem.

On Wed, Aug 27, 2008 at 06:19:01PM +0900, Magnus Damm wrote:
> The crash kernel entry point is currently checked by the kexec kernel
> code and only physical addresses in the reserved memory window are
> accepted. This means that we can't pass P2 or P1 addresses as entry
> points in the case of crash kernels. This patch makes sure we can start
> crash kernels by adding support for physical address entry points.

On Wed, Aug 27, 2008 at 06:21:29PM +0900, Magnus Damm wrote:
> This patch kills a section mismatch for platform_resource_setup_memory().

On Wed, Aug 27, 2008 at 06:22:49PM +0900, Magnus Damm wrote:
> This patch updates the MigoR defconfig to include the recently merged
> uio_pdrv_genirq driver.

On Wed, Aug 27, 2008 at 06:23:52PM +0900, Magnus Damm wrote:
> This patch updates the AP325RXA defconfig to include the recently merged
> uio_pdrv_genirq driver.

Applied, thanks.
