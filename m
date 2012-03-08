From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Mar 2012 01:24:30 +0000
Subject: Re: Migo-R (SH7722) vs. NUMA
Message-Id: <878vjbc2b8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762egpvhn.fsf@schwinge.name>
In-Reply-To: <8762egpvhn.fsf@schwinge.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Thomas

> I've been working on upgrading the kernel for our Migo-R (SH7722) board
> From ancient 2.6.30.6 to something more modern, 3.2.  But, based on
> migor_defconfig, it wouldn't boot, and instead just hang after the boot
> loader.  I bisected this to commit
> 19d8f84f86af867abee174be8bf1e4941a59143d (2010-05-10).  (To build this
> tree, you need to cherry-pick 06225c08ec2ad0f0dec063df7f08773a8358db12
> and apply the equivalent of c77b29db74a0ea4fdce0564a63b8876798625d64 to
> arch/sh/kernel/setup.c.)
> 
> By chance I figured out that disabling NUMA support (which is enabled for
> migor_defconfig) would make it work again for this tree, as well as later
> versions, such as the 3.2 release.  I guess this should be fixed
> properly?

I forgot detail of MIGO-R.
But in my quick check,
my MIGO-R .config doesn't have CONFIG_NUMA since around v2.6.32-rc5

Best regards
---
Kuninori Morimoto
