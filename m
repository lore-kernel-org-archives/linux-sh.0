From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 02 Jun 2009 03:17:42 +0000
Subject: Re: [PATCH v2 0/4] add L2 cache support
Message-Id: <20090602031742.GA17378@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ueiu3e4f2.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ueiu3e4f2.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 02, 2009 at 11:49:05AM +0900, Kuninori Morimoto wrote:
> 
> These are v2 patches to add support L2 cache
> 
> [PATCH 1/4] cache.h: add RAMCR definition for sh4
> [PATCH 2/4] sh: add l2_cache_init function on cache_init
> [PATCH 3/4] sh7724: add l2_cache_init support
> [PATCH 4/4] sh7723: add l2_cache_init support

Looks better, applied, thanks.
