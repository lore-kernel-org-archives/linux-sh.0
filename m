From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 01 Mar 2013 10:01:17 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: armadillo800eva: enable all errata for cache on defconfig
Message-Id: <uobf3saky.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1346808893-14124-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1346808893-14124-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Simon

Sorry for my late response

> > > Some errata for cache had not enabled on current
> > > Armadillo800eva defconfig.
> > > This patch enables these.
> > > Special thanks to Ishiyama-san
> > 
> > It seems to me that it would be better to handle these in Kconfig
> > to enable them on an SoC or board basis.
> > 
> > The reason is that I would like to move away from per-board defconfigs
> > and towards a more consolidated defconfig. And in that case it will
> > be more difficult to know which ERRATA are needed for each board and SoC.
> > 
> > Obviously this thinking is open to review and it implies that
> > several board defconfigs should be updated.

We used defconfig selection for CPU/board settings before.
But Kconfig selection for ERRATA make sense.

Do you want to me to send v2 patch which use Kconfig ?
Or do you do that ?


Best regards
--
Kuninori Morimoto
 
