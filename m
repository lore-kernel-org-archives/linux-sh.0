From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Nov 2013 03:32:28 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: fixup compile error
Message-Id: <20131119033226.GA30900@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3g5drmh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3g5drmh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 18, 2013 at 06:58:49PM -0800, Kuninori Morimoto wrote:
> This patch solve this compile error
> 
>   CC      arch/arm/mach-shmobile/board-lager-reference.o
> ${LINUX}/arch/arm/mach-shmobile/board-lager-reference.c:44:15:\
>    error: 'shmobile_init_late' undeclared here (not in a function)
> make[3]: *** [arch/arm/mach-shmobile/board-lager-reference.o] Error 1
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks.

I have taken an alternate approach which is to drop the patch
that caused the problem.
