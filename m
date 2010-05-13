From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 May 2010 08:50:38 +0000
Subject: Re: [PATCH] sh: Check return value of clk_get on ecovec24
Message-Id: <20100513085038.GC11391@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uaas4lib3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <uaas4lib3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 13, 2010 at 10:08:33AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c |   24 +++++++++++++++---------
>  1 files changed, 15 insertions(+), 9 deletions(-)

On Thu, May 13, 2010 at 10:08:37AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/sh/boards/mach-se/7724/setup.c |   18 +++++++++++-------
>  1 files changed, 11 insertions(+), 7 deletions(-)

Both applied, thanks.
