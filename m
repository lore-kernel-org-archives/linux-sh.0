From: Simon Horman <horms@verge.net.au>
Date: Thu, 13 Feb 2014 05:20:53 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: Koelsch legacy SDHI support
Message-Id: <20140213052049.GA17910@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212042552.10516.10308.sendpatchset@w520>
In-Reply-To: <20140212042552.10516.10308.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 12, 2014 at 01:25:52PM +0900, Magnus Damm wrote:
> ARM: shmobile: Koelsch legacy SDHI support
> 
> [PATCH 01/03] ARM: shmobile: Add r8a7791 legacy SDHI clocks
> [PATCH 02/03] pinctrl: sh-pfc: r8a7791: SD1_CLK fix
> [PATCH 03/03] ARM: shmobile: Add SDHI devices for legacy Koelsch


> 
> Add SDHI devices to the legacy Koelsch board support. While at it
> fix missing PFC bits for SDHI1 and also add legacy clocks. Each
> of the patches can be merged independently without compile
> failure, but all of them are required for correct SDHI run time
> operation on the Koelsch board. Next step is DTSI and DTS which
> will be handled in a separate series.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/board-koelsch.c |  155 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7791.c |   51 ++++++++++
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c   |    6 -
>  3 files changed, 208 insertions(+), 4 deletions(-)

Thanks Magnus.

I have queued up patches 1 and 3 for v3.15.
I believe that patch 2 is for Laurent.
