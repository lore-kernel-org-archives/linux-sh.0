From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 May 2012 01:49:53 +0000
Subject: Re: [PATCH 0/12 v2] ARM: mach-shmobile: armadillo: add FSI/HDMI/Camera support
Message-Id: <20120523014953.GA11860@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87hav7vg65.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hav7vg65.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 22, 2012 at 06:29:09PM -0700, Kuninori Morimoto wrote:
> These are v2 patch set for r8a7740/armadillo FSI/HDMI/Camera support
> v2 includes yesterday's my
> ARM: mach-shmobile: add extra gpio setting functions
> 
> Kuninori Morimoto (12):
>       ARM: mach-shmobile: shareing extra gpio setting functions
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
> 
> v1 -> v2
> 
>  - "ARM: mach-shmobile: add extra gpio setting functions" became 1st patch
>  - #3 work-around is called from board code
>  - #11 patch used gpio_direction_none()
> 
Updated series looks good to me.
