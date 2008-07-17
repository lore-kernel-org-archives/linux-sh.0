From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Jul 2008 05:54:05 +0000
Subject: Re: [PATCH] sh: Export sh7343 VPU and VEU using uio_pdrv_genirq
Message-Id: <20080717055405.GB12007@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080715125139.10218.34702.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080715125139.10218.34702.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 15, 2008 at 09:51:39PM +0900, Magnus Damm wrote:
> This patch exports the VPU and VEU blocks of the sh7343 to user space
> using the uio_pdrv_genirq platform driver.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Tue, Jul 15, 2008 at 09:52:19PM +0900, Magnus Damm wrote:
> This patch exports the VPU and VEU blocks of the sh7722 to user space
> using the uio_pdrv_genirq platform driver.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Tue, Jul 15, 2008 at 09:53:33PM +0900, Magnus Damm wrote:
> This patch exports the VPU, VEU2H0 and VEU2H1 blocks of the sh7723
> to user space using the uio_pdrv_genirq platform driver.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Tue, Jul 15, 2008 at 09:55:03PM +0900, Magnus Damm wrote:
> This patch exports the VPU, VEU(1) and VEU(2) blocks of the sh7366
> to user space using the uio_pdrv_genirq platform driver.
> 
> While at it, fix up the VEU(2) interrupt vector.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Wed, Jul 16, 2008 at 07:02:54PM +0900, Magnus Damm wrote:
> This patch adds physically contiguous memory chunks to the UIO devices.
> The same strategy can be used in the future for the CEU as well.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.
