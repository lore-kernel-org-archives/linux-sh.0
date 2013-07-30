From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 02:40:10 +0000
Subject: Re: [PATCH 2/6 v2] ARM: shmobile: r8a7778: cleanup registration of usb phy
Message-Id: <20130730024009.GJ31526@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874nbhdbaw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nbhdbaw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 26, 2013 at 03:54:44PM +0900, Kuninori Morimoto wrote:
> usb phy driver which needs platform data at the time of
> registration is used from BockW only.
> Now, ARM/shmobile aims to support DT,
> and the C code base board support will be removed
> if DT support is completed.
> Current driver registration method which needs platform data
> and which is not shared complicates codes.
> This means legacy C code cleanup after DT supporting
> will be more complicated
> This patch registers it on board code as cleanup C code
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up for v3.12 in the cleanup3 branch.
