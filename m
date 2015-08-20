From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Aug 2015 18:54:40 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound
Message-Id: <20150820185437.GF18990@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bne2daam.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bne2daam.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 20, 2015 at 01:25:20AM +0000, Kuninori Morimoto wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> 6e3a43d ("ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain")
> added CPG/MSTP clock-cells domain support, but it was missing sound
> support. This patch adds it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I have queued this up as a fix for v4.3 with a minor tweak:

It seems that the commit id that made it into the arm-soc tree differs
from the above. I have updated the changelog to refer to 797a0626e08c
accordingly.
