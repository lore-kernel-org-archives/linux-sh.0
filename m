From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 30 Mar 2009 22:44:42 +0000
Subject: Re: [PATCH] sh7786: remove buggy definition from pinmux_data[]
Message-Id: <20090330224442.GA19535@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u1vskdc5w.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u1vskdc5w.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 25, 2009 at 05:54:23PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> This patch is for linux-next
> 
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

On Thu, Mar 26, 2009 at 09:24:01AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> This patch is for linux-next
> 
>  arch/sh/boards/board-urquell.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

On Thu, Mar 26, 2009 at 09:39:49AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> This patch is for linux-next
> 
>  arch/sh/include/cpu-sh4/cpu/sh7786.h    |  214 +++++++++++-------------------
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |  184 ++++++---------------------
>  2 files changed, 118 insertions(+), 280 deletions(-)

Applied, thanks.
