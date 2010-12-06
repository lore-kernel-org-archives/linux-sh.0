From: Simon Horman <simon@horms.net>
Date: Mon, 06 Dec 2010 00:44:52 +0000
Subject: Re: [patch 3/3] mmc, ARM: Add zboot from MMC support for SuperH
Message-Id: <20101206004452.GA30296@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20101206001243.949375995@vergenet.net>
	<20101206001310.825497890@vergenet.net>
In-Reply-To: <20101206001310.825497890@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 06, 2010 at 09:12:46AM +0900, Simon Horman wrote:
> This allows a ROM-able zImage to be written to MMC and
> for SuperH Mobile ARM to boot directly from the MMCIF
> hardware block.
> 
> This is achieved by the MaskROM loading the first portion
> of the image into MERAM and then jumping to it. This portion
> contains loader code which copies the entire image to SDRAM
> and jumps to it. From there the zImage boot code proceeds
> as normal, uncompressing the image into its final location
> and then jumping to it.
> 
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> --- 
> 
> This patch depends on "ARM: 6514/1: mach-shmobile: Add zboot support for
> SuperH Mobile ARM" which has been merged into the devel branch
> of Russell King's linux-2.6-arm tree.

This patch also depends on the previous two patches in this series.

