From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 04 Dec 2014 09:48:28 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: defconfig: cleanup by savedefconfig
Message-Id: <87tx1b7nk6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uio83sx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uio83sx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> Note that you best keep your old .config generated from shmobile_defconfig
> and run "make oldconfig". That will catch cases where a "select" was
> dropped from a Kconfig file. When just running "make shmobile_defconfig",
> you may end up with a .config where some option is suddenly disabled
> because it's no longer selected automatically.

Thanks ! I didn't know that.

# I tried "shmobile_defconfig + oldconfig" on latest tree.
# and there is no difference between nomal "shmobile_defconfig" and above.
# I guess 1/1 patch was OK this time.

Best regards
---
Kuninori Morimoto
