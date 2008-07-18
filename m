From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 18 Jul 2008 07:40:35 +0000
Subject: Re: [PATCH 00/06] soc_camera: SuperH Mobile CEU patches V3
Message-Id: <Pine.LNX.4.64.0807180940010.13569@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080714120204.4806.87287.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: video4linux-list@redhat.com, paulius.zaleckas@teltonika.lt, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, lethal@linux-sh.org, akpm@linux-foundation.org

On Mon, 14 Jul 2008, Magnus Damm wrote:

> This is V3 of the SuperH Mobile CEU interface patches.
> 
> [PATCH 01/06] soc_camera: Move spinlocks
> [PATCH 02/06] soc_camera: Add 16-bit bus width support
> [PATCH 03/06] videobuf: Fix gather spelling
> [PATCH 04/06] videobuf: Add physically contiguous queue code V3
> [PATCH 05/06] sh_mobile_ceu_camera: Add SuperH Mobile CEU driver V3
> [PATCH 06/06] soc_camera_platform: Add SoC Camera Platform driver
> 
> Changes since V2:
>  - use dma_handle for physical address for videobuf-dma-contig
>  - spell gather correctly
>  - remove SUPERH Kconfig dependency
>  - move sh_mobile_ceu.h to include/media
>  - add board callback support with enable_camera()/disable_camera()
>  - add support for declare_coherent_memory
>  - rework video memory limit
>  - more verbose error messages
>  - add soc_camera_platform driver for simple camera devices
> 
> Changes since V1:
>  - dropped former V1 patches [01/07]->[04/07]
>  - rebased on top of [PATCH] soc_camera: make videobuf independent
>  - rewrote spinlock changes into the new [01/04] patch
>  - updated the videobuf-dma-contig code with feeback from Paulius Zaleckas
>  - fixed the CEU driver to work with the newly updated patches
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---

Thanks, applied to soc-camera.

Guennadi
---
Guennadi Liakhovetski
