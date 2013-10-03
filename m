From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:15:25 +0000
Subject: Re: [PATCH 4/4 v2] ARM: shmobile: marzen: fixup SMSC IRQ number on DTS
Message-Id: <20131003041523.GH7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8761tgysjy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761tgysjy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 02, 2013 at 01:40:20AM -0700, Kuninori Morimoto wrote:
> This patch fixup miss-setting of SMSC IRQ number.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Thanks, I have queued this up in the dt3 branch.
It should make it into v3.13 but if not I'll rename the branch
dt after rebasing it on v3.13-rcX which will then be targeted at v3.14.
