From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Jun 2013 08:00:15 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: armadillo800eva: remove left-overs
Message-Id: <20130627080015.GC13927@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bok7lm0h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bok7lm0h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 06, 2013 at 05:38:11PM +0200, Guennadi Liakhovetski wrote:
> A comment and a #define in board-armadillo800eva.c have been left over
> after recent changes and are no longer relevant or needed, remove them.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, I have queued this up for v3.12 in the cleanup branch.
