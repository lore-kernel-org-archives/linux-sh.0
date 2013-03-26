From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Mar 2013 06:17:06 +0000
Subject: Re: [PATCH 0/1] ARM: shmobile: r8a73a4 thermal support
Message-Id: <87mwtqit29.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326013414.11796.9937.sendpatchset@w520>
In-Reply-To: <20130326013414.11796.9937.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon, Magnus

This patch add thermal driver support on r8a73a4.

> ARM: shmobile: r8a73a4 SoC support V3
> [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support V3
> [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support V3
> [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
> [PATCH 04/04] ARM: shmobile: r8a73a4 PFC support

This patch is based on...

simon/next branch

And, Magnus's
    ARM: shmobile: r8a73a4 SoC support V3
    sh-pfc: Initial r8a73a4 PFC support
    ARM: shmobile: r8a73a4 APE6EVM board support V2

And, Zhang's (= PM ML)

f0e68fc3caf677e834f7bd0f601800e686b56c98
(thermal: rcar: fix missing unlock on error in rcar_thermal_update_temp())

fb84d9907f0ff0e3f7d70d55039ddf0f78d2a472
(thermal: rcar_thermal: propagate return value of thermal_zone_device_register)

And, my previous
      thermal: rcar: tidyup registration failure case
      thermal: rcar: add pm_runtime_xxx() support

Simon, please let me know if you need my help
