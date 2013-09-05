From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Sep 2013 05:53:09 +0000
Subject: Re: [PATCH 2/5 v2] ARM: shmobile: r8a7778: add SSI/SRU clock support
Message-Id: <20130905055307.GD14960@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 26, 2013 at 01:51:37AM -0700, Kuninori Morimoto wrote:
> Add a platform clock for the r8a7778 SRU/SSI sound.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  v1 -> v2
> 
>  - no change
> 
>  arch/arm/mach-shmobile/clock-r8a7778.c |   43 ++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)

Thanks, I have queued this up for v3.13.
