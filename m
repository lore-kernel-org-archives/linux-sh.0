From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:16:06 +0000
Subject: Re: [PATCH 2/4 v2] ARM: shmobile: r8a7779: add irqpin default status on DTSI
Message-Id: <20131003041605.GI7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878uycyslu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uycyslu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 02, 2013 at 01:39:13AM -0700, Kuninori Morimoto wrote:
> r8a7779 INTC needs IRL pin mode settings to determine
> behavior of IRQ0 - IRQ3. But it depends on platform.
> This patch adds status = "disabled" on r8a7779.dtsi as default
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up in the dt3 branch.
It should make it into v3.13 but if not I'll rename the branch
dt after rebasing it on v3.13-rcX which will then be targeted at v3.14.
