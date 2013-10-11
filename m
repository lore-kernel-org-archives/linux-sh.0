From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Oct 2013 01:29:22 +0000
Subject: Re: [PATCH 4/7] ARM: shmobile: bockw: remove manual PFC settings on reference
Message-Id: <20131011012920.GC17597@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y569zur5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y569zur5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 03, 2013 at 06:32:01PM -0700, Kuninori Morimoto wrote:
> Current Bock-W reference is calling PFC initializer manually,
> but now, it can use DTS PFC.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up.
