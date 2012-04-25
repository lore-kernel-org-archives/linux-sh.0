From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Apr 2012 07:01:53 +0000
Subject: Re: [PATCH 0/2][for LTSI] ARM: mach-shmobile: KZM-A9-GT sound support
Message-Id: <20120425070153.GC19454@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871unf9bi7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871unf9bi7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 23, 2012 at 12:02:28AM -0700, Kuninori Morimoto wrote:
> 
> Hi Rafael, Magnus
> Cc Simon
> 
> These are KZM-A9-GT sound support patches,
> but it needs ASoC/for-3.5 branch merge.
> 
> Of course I will re-post these patches after merge.
> I post it now for Simon's backport work of LTSI support.
> 
> Kuninori Morimoto (2):
>       ARM: mach-shmobile: clock-sh73a0: add FSI clock
>       ARM: mach-shmobile: kzm9g: add FSI-AK4648 support

Both patches,

Tested-by: Simon Horman <horms@verge.net.au>

> #2 patch needs below patches from ASoC/for-3.5 branch
> (git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git)
> 
> 7c384c09ffd08c72a784c9c7804a17916a439cb1
> (ASoC: add generic simple-card support)
> 
> 0717a5fa422edbd650ada2f0a4e3075b3d4f8528
> (ASoC: sh: fsi: select simple-card on Kconfig)
> 
> Best regards
> ---
> Kuninori Morimoto
> 
