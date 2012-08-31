From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Aug 2012 00:38:04 +0000
Subject: Re: [PATCH 2/8] ARM: shmobile: r8a7779: add USB common phy initializer
Message-Id: <20120831003802.GM7721@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3wjdbf1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3wjdbf1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 27, 2012 at 06:59:17PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> This patch adds common USB phy ports initializer for r8a7779.
> 
> The note is that each USB IP have own MSTP clock bit,
> and common USB phy port doesn't have MSTP clock,
> but this USB phy needs USB clock.
> Each USB driver / platform should keep USB MSTP clock somehow.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, applied to the marzen branch, which is based on usb-next.
