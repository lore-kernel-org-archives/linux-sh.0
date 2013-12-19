From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Dec 2013 09:06:26 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: koelsch: defconfig updates
Message-Id: <20131219090626.GE12239@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387154049-9105-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1387154049-9105-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 16, 2013 at 09:34:07AM +0900, Simon Horman wrote:
> Updates for Koelsch defconfig to allow it to boot
> a Debian armhf userspace and to bring it into line
> with other shmobile defconfigs.
> 
> Based on the renesas-devel-v3.13-rc3-20131214v2 tag
> of my renesas tree.
> 
> Simon Horman (2):
>   ARM: shmobile: koelsch: Enable CONFIG_PACKET in defconfig
>   ARM: shmobile: koelsch: Do not disable CONFIG_{INOTIFY_USER,UNIX} in
>     defconfig
> 
>  arch/arm/configs/koelsch_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I have queued these up.
