From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 06 Dec 2010 03:55:04 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: AG5 clock framework improvements
Message-Id: <20101206035503.GA4968@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101203072231.9395.36382.sendpatchset@t400s>
In-Reply-To: <20101203072231.9395.36382.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 03, 2010 at 04:22:31PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch improves the state of the AG5 clock
> framework support. The main clock parent is
> automatically detected, but most of the clocks
> are not used by any driver or subsystem at this
> point. More work is needed for support of multi
> media hardware such as FSI and/or LCDC/MIPI-DSI.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Applies to the "rmobile/ag5" branch in the sh-2.6 git repo.
> 
>  arch/arm/mach-shmobile/clock-sh73a0.c        |  279 +++++++++++++++++++++++---
>  arch/arm/mach-shmobile/include/mach/common.h |    2 
>  2 files changed, 256 insertions(+), 25 deletions(-)
> 
Applied, thanks.
