From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Sep 2013 04:52:31 +0000
Subject: Re: [PATCH v4 1/2] ARM: shmobile: r8a7778: add HPB-DMAC support
Message-Id: <20130927045231.GE16541@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201308250133.17530.sergei.shtylyov@cogentembedded.com>
 <201308250135.14393.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308250135.14393.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Aug 25, 2013 at 01:35:13AM +0400, Sergei Shtylyov wrote:
> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Add HPB-DMAC platform device on R8A7778 SoC along with its slave and channel
> configurations (only for SDHI0 so far).
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> [Sergei: moved *enum* declaring HPB-DMAC slave IDs from now removed <mach/dma.h>
> to <mach/r8a7778.h>, removed #include <mach/dma.h> from setup-r8a7778.c, removed
> SSI-related *enum* values and SSI-related data from hpb_dmae_slaves[] and
> hpb_dmae_channels[], moved the comments after the element initializers of
> hpb_dmae_channels[].]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> Changes in version 4:
> - renamed all the bit/field #define's to include 'HBP_DMAE_' prefix to match
>   the driver.
> 
> Changes in version 3:
> - changed ASYNCMDR_ASMD2[12]_SINGLE to ASYNCMDR_ASMD2[12]_MULTI in the 'mdr'
>   field initializers;
> - moved the comments after the element initializers of hpb_dmae_channels[];
> - resolved rejects, refreshed the patch.
> 
> Changes in version 2:
> - moved *enum* declaring HPB-DMAC slave IDs from the separate header file to
>   <mach/r8a7778.h>, removed #include <mach/dma.h> from setup-r8a7778.c;
> - removed SSI-related *enum* values and SSI-related data from hpb_dmae_slaves[]
>   and hpb_dmae_channels[].
> 
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |    8 ++
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   85 ++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)

Thanks, queued up for v3.13.
