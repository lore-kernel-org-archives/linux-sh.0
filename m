From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 23 May 2012 01:29:09 +0000
Subject: Re: [PATCH 0/12 v2] ARM: mach-shmobile: armadillo: add FSI/HDMI/Camera support
Message-Id: <87hav7vg65.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Paul, Magnus
Cc Simon

> The necessary missing patches for Armadillo will be merged on v3.5 kernel.
> These are ASoC/FSI/HDMI/CEU/.
> (and already exists on linux-next tree)
> 
> These patch set add HDMI/camera/FSI sound x2 to Armadillo board for v3.5 kernel.
> 
> Kuninori Morimoto (11):
>       ARM: mach-shmobile: intc-r8a7740: add HDMI support
>       ARM: mach-shmobile: setup-r8a7740: add MERAM work-around
>       ARM: mach-shmobile: clock-r8a7740: add HDMI clock
>       ARM: mach-shmobile: clock-r8a7740: add CEU support
>       ARM: mach-shmobile: clock-r8a7740: add FSI parent control support
>       ARM: mach-shmobile: pfc-r8a7740: Add HDMI GPIO support
>       ARM: mach-shmobile: pfc-r8a7740: add FSI-B (for HDMI) support
>       ARM: mach-shmobile: armadillo800eva: add HDMI support
>       ARM: mach-shmobile: armadillo800eva: add camera support
>       ARM: mach-shmobile: armadillo800eva: Add FSI-WM8978 support
>       ARM: mach-shmobile: armadillo800eva: add FSI-HDMI support

These are v2 patch set for r8a7740/armadillo FSI/HDMI/Camera support
v2 includes yesterday's my
ARM: mach-shmobile: add extra gpio setting functions

Kuninori Morimoto (12):
      ARM: mach-shmobile: shareing extra gpio setting functions
      ARM: mach-shmobile: intc-r8a7740: add HDMI support
      ARM: mach-shmobile: setup-r8a7740: add MERAM work-around
      ARM: mach-shmobile: clock-r8a7740: add HDMI clock
      ARM: mach-shmobile: clock-r8a7740: add CEU support
      ARM: mach-shmobile: clock-r8a7740: add FSI parent control support
      ARM: mach-shmobile: pfc-r8a7740: Add HDMI GPIO support
      ARM: mach-shmobile: pfc-r8a7740: add FSI-B (for HDMI) support
      ARM: mach-shmobile: armadillo800eva: add HDMI support
      ARM: mach-shmobile: armadillo800eva: add camera support
      ARM: mach-shmobile: armadillo800eva: Add FSI-WM8978 support
      ARM: mach-shmobile: armadillo800eva: add FSI-HDMI support

v1 -> v2

 - "ARM: mach-shmobile: add extra gpio setting functions" became 1st patch
 - #3 work-around is called from board code
 - #11 patch used gpio_direction_none()

Best regards
---
Kuninori Morimoto
