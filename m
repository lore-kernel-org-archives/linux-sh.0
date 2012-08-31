From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Aug 2012 00:39:22 +0000
Subject: Re: [PATCH 7/8] ARM: shmobile: marzen: enable thermal sensor
Message-Id: <20120831003920.GD21634@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d32bdbdf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d32bdbdf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 27, 2012 at 07:00:15PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> Marzen board can measure its thermal by this patch.
> 	cat /sys/class/thermal/thermal_zoneX/temp
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, applied to the marzen branch, which is based on usb-next.
