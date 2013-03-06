From: Simon Horman <horms@verge.net.au>
Date: Wed, 06 Mar 2013 04:46:05 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: armadillo800eva: enable all errata for cache on defconfig
Message-Id: <20130306044603.GA18177@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346808893-14124-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1346808893-14124-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 21, 2013 at 08:45:57PM -0800, Kuninori Morimoto wrote:
> Some errata for cache had not enabled on current
> Armadillo800eva defconfig.
> This patch enables these.
> Special thanks to Ishiyama-san
> 
> Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, applied to the defconfig branch of the renesas tree
and thus included in its next branch and queued up for v3.10.
