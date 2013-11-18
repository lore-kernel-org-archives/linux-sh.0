From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Nov 2013 08:38:33 +0000
Subject: Re: [PATCH 2/2 v2] ARM: shmobile: r8a7779: cleanup registration of sh_eth
Message-Id: <20131118083831.GC1506@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87habint8a.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87habint8a.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 11, 2013 at 08:23:36PM -0800, Kuninori Morimoto wrote:
> sh_eth driver which needs platform data at the time of
> registration is not used.
> Now, ARM/shmobile aims to support DT,
> and the C code base board support will be removed
> if DT support is completed.
> Current driver registration method which needs platform data
> and which is not shared complicates codes.
> This means legacy C code cleanup after DT supporting
> will be more complicated
> This patch removes r8a7779_add_ether_device()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up.
