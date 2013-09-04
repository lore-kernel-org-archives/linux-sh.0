From: Simon Horman <horms@verge.net.au>
Date: Wed, 04 Sep 2013 08:55:39 +0000
Subject: Re: [PATCH v5 0/7] DMA: shdma: switch DT to use OF device ID tables
Message-Id: <20130904085539.GE25209@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375455042-24093-1-git-send-email-g.liakhovetski@gmx.de>
 <20130825073656.GF8091@intel.com>
 <20130826071725.GJ26682@verge.net.au>
 <Pine.LNX.4.64.1308291321260.3786@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1308291321260.3786@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Thu, Aug 29, 2013 at 01:24:31PM +0200, Guennadi Liakhovetski wrote:
> Hi Simon,
> 
> On Mon, 26 Aug 2013, Simon Horman wrote:
> 
> > On Sun, Aug 25, 2013 at 01:06:57PM +0530, Vinod Koul wrote:
> > > On Fri, Aug 02, 2013 at 04:50:35PM +0200, Guennadi Liakhovetski wrote:
> > > > In this version of shdma Device Tree support I preserved the DT 
> > > > configuration approach via OF device ID tables from v4, but now it is only 
> > > > used for the DT-mode, the C-version is left untouched. In this series I 
> > > > only include one platform: r8a73a4-based APE6EVM, if accepted, others can 
> > > > be added easily. I also took care not to include mach/*.h headers in 
> > > > driver .c files. To illustrate the use of DT DMA support for MMC DMA on 
> > > > APE6EVM a patch from a previously separate patch series "DMA for MMCIF and 
> > > > SDHI devices in DT mode"
> > > I have applied all the dma patches, the ARM ones fail for me so should possible
> > > go thru ARM tree.
> > 
> > Guennadi, if you need me to queue up any patches please repost them
> > once their dependencies are available in a stable branch.
> 
> I've just verified, that the current -next has all DMA and MMCIF 
> prerequisites for the following my patches:
> 
>       ARM: shmobile: armadillo800eva-reference: add MMCIF and SDHI DT nodes
>       ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
>       ARM: shmobile: r8a73a4: add a DT node and a clock alias for the DMAC
>       ARM: shmobile: ape6evm-reference: enable DMA for the MMC interface
>       ARM: shmobile: ape6evm: disable MMCIF Command Completion Signal
>       ARM: shmobile: ape6evm: add DMA support to MMCIF
>       ARM: shmobile: armadillo800eva: disable MMCIF Command Completion Signal
>       ARM: shmobile: kzm9g: disable MMCIF Command Completion Signal
>       ARM: shmobile: lager: disable MMCIF Command Completion Signal, add CLK_CTRL2
> 
> I can re-send them all to your privetly as an archive, if you like, or you 
> can pick their latest versions from an archive or from patchwork.

Thanks, I can pick them out of patchwork.
