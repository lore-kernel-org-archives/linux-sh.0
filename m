From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Jun 2011 10:51:35 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0: add MMC data pin pull-up
Message-Id: <20110630105134.GB15940@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87k4c34vzl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k4c34vzl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 30, 2011 at 12:30:29AM -0700, Kuninori Morimoto wrote:
> Add MMC data pin pull-up option and select it for ag5evm.
> The MMC read/write will be error if without this patch

Thanks Morimoto-san.

In case anyone cares, I intend to test this patch next week
when I should have access to the relevant hardware.

