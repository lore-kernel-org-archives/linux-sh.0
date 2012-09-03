From: Simon Horman <horms@verge.net.au>
Date: Mon, 03 Sep 2012 08:34:25 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: enable rw rootfs mount
Message-Id: <20120903083423.GC16456@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 02, 2012 at 11:06:52PM -0700, Kuninori Morimoto wrote:
> armadillo800eva default boot loader is "hermit",
> and it's tag->u.core.flags has flag when kernel boots.
> Because of this, ${LINUX}/arch/arm/kernel/setup.c :: parse_tag_core()
> didn't remove MS_RDONLY flag from root_mountflags.
> Thus, the rootfs is mounted as "readonly".
> This patch adds "rw" kernel parameter,
> and enable read/write mounts for rootfs

Thanks, applied to the fixes branch of my reneas tree.
I will endeavour to get this included in 3.6.

FWIW, I believe that I have run into this problem.
