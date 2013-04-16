From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Apr 2013 06:19:13 +0000
Subject: Re: [PATCH 2/4 v2] ARM: shmobile: r8a7790: add main clock
Message-Id: <20130416061912.GC27462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87txncnqjp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txncnqjp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 12, 2013 at 12:42:22AM -0700, Kuninori Morimoto wrote:
> Almost all clock needs main clock which is basis clock on r8a7790.
> This patch adds it, and, set its parent/ratio via MD pin.
> It is based on v0.05 datasheet
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued-up for v3.11 in the soc-r8a7790 branch.
