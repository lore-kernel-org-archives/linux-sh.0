From: Simon Horman <horms@verge.net.au>
Date: Mon, 01 Jul 2013 01:30:36 +0000
Subject: Re: [PATCH 0/3] R8A7778/BOCK-W: HPB-DMAC support for SDHI0
Message-Id: <20130701013036.GC14567@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Jun 30, 2013 at 02:43:56AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130628' tag. Here we add the HPB-DMAC platform code working on
> the R8A7778 and enable DMA for SDHI0 on BOCK-W. The patchset depends on the
> R-Car HPB-DMAC driver patch posted earlier.
> 
> [1/3] ARM: shmobile: use common platform header for HPB-DMAC
> [2/3] ARM: shmobile: r8a7778: add HPB-DMAC support
> [3/3] ARM: shmobile: BOCK-W: enable DMA for SDHI0

Hi Magnus, Hi Morimoto-san,

could you please review is series?
