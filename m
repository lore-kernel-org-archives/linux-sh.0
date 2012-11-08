From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2012 07:58:08 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: board used FSI driver's clock
Message-Id: <87r4o4zfub.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for your hard work

> a) looks sane
> b) anything is missing

> * 7e7477a (origin/boards, boards) ARM: shmobile: use FSI driver's audio clock on ap4evb

This patch chaned to use FSI driver's audio clock,
then, it removed old style clock settings.
But...

> * 38f8b5f ARM: shmobile: use FSI driver's audio clock on mackerel
> * 23d98fe ARM: shmobile: use FSI driver's audio clock on armadillo800eva
> * 19bf12f ARM: shmobile: mackerel: enable DMAEngine on USB Host
> * 6188248 ARM: shmobile: marzen: add USB OHCI driver support
> * 4f75b75 ARM: shmobile: marzen: add USB EHCI driver support
> * 44051e2 ARM: shmobile: marzen: add USB phy support
> *   092cb53 Merge branch 'soc' into boards
> |\  
> | * c089609 (origin/soc, soc) ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
> | * 2a14f32 ARM: shmobile: sh7372: remove fsidivx clock

These 2 patches are depend on above patches,
becouse these patches remove sh7372_xxx fsi clocks (= old style clock).
This means that there is compile error on ap4evb board from 2a14f32 to 38f8b5f.
and it is not good for "git bisect"

Can you change patch order like this ?

 xxxxxxx ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
 xxxxxxx ARM: shmobile: sh7372: remove fsidivx clock
...
 xxxxxxx ARM: shmobile: use FSI driver's audio clock on ap4evb
 xxxxxxx ARM: shmobile: use FSI driver's audio clock on mackerel
 xxxxxxx ARM: shmobile: use FSI driver's audio clock on armadillo800eva
...
 xxxxxxx ARM: shmobile: add fsi external clock sh7372
 xxxxxxx ARM: shmobile: add fsi external clock on r8a7740
 xxxxxxx ARM: shmobile: r8a7740: add FSI-DVI clocks
 xxxxxxx ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
....

Best regards
---
Kuninori Morimoto
