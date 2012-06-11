From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 08:01:29 +0000
Subject: Re: [PATCH 01/27] ARM: shmobile: sh73a0: bugfix: SY-DMAC number
Message-Id: <20120611080128.GI30048@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87lijuqzfs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lijuqzfs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:50:51PM -0700, Kuninori Morimoto wrote:
> 681e1b3eeb3606e06a7c4984e8058df84296f8bb
> (ARM: mach-shmobile: sh73a0 DMA Engine support for SY-DMAC)
> adds SY-DMAC, but it is 218, not 318
> 
> This patch is based on v2.0 manual
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Morimoto-san,

I am unsure of how to test this change.
Is checking that DMAE works with FSI using subsequent patches
in this series a sufficient test?
