From: Vinod Koul <vinod.koul@intel.com>
Date: Sun, 25 Aug 2013 07:48:57 +0000
Subject: Re: [PATCH v5 0/7] DMA: shdma: switch DT to use OF device ID tables
Message-Id: <20130825073656.GF8091@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375455042-24093-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1375455042-24093-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Fri, Aug 02, 2013 at 04:50:35PM +0200, Guennadi Liakhovetski wrote:
> In this version of shdma Device Tree support I preserved the DT 
> configuration approach via OF device ID tables from v4, but now it is only 
> used for the DT-mode, the C-version is left untouched. In this series I 
> only include one platform: r8a73a4-based APE6EVM, if accepted, others can 
> be added easily. I also took care not to include mach/*.h headers in 
> driver .c files. To illustrate the use of DT DMA support for MMC DMA on 
> APE6EVM a patch from a previously separate patch series "DMA for MMCIF and 
> SDHI devices in DT mode"
I have applied all the dma patches, the ARM ones fail for me so should possible
go thru ARM tree.

thanks
~Vinod
