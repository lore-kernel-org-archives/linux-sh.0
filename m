From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Oct 2013 04:09:30 +0000
Subject: Re: [PATCH 2/7] ARM: shmobile: bockw: use regulator for MMCIF
Message-Id: <20131008040928.GB29850@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874n8x256b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874n8x256b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 03, 2013 at 06:30:55PM -0700, Kuninori Morimoto wrote:
> When regulators are used with MMC devices, sh_mmcif_plat_data::ocr
> is not needed, they can be removed from platform data.
> This patch adds v3.3 regulator settings,
> and moved fixed-dummy regulator registration position
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up.
