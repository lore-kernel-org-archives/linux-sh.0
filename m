From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 22 Oct 2009 01:56:00 +0000
Subject: Re: [PATCH] sh: add SuperH DAC audio driver for ALSA V2
Message-Id: <20091022015600.GA26660@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091008013423.GA26059@rafazurita.homelinux.net>
In-Reply-To: <20091008013423.GA26059@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 20, 2009 at 10:38:36PM -0300, Rafael Ignacio Zurita wrote:
> This is a port of the sound/oss/sh_dac_audio.c driver.
> The driver uses an on-chip 8-bit D/A converter, which has a speaker connected
> to one of its channels, found in several ancient HP machines.
> For interrupts it uses a high-resolution timer (hrtimer).
> Tested on SH7709 based hp6xx (HP Jornada 680/690 and HP Palmtop 620lx/660lx).
>  
> Also, since OSS Emulation works, the old OSS sound/oss/sh_dac_audio.c driver
> would be obsolete soon, and it could be removed.
>  
> Changes since V1:
>  - moved the platform device code into board code.
>  - dropped dac_audio_sync(), since that code is not needed (it was inherited of
>    the old oss driver).
>  - rewrote the code with style problems.
>  
> Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>
> ---
>  arch/sh/boards/mach-hp6xx/setup.c        |   55 ++++
>  arch/sh/include/mach-common/mach/hp6xx.h |    4 +
>  include/sound/dac_audio.h                |   21 ++
>  sound/sh/Kconfig                         |    8 +
>  sound/sh/Makefile                        |    1 +
>  sound/sh/snd_sh_dac_audio.c              |  453 ++++++++++++++++++++++++++++++
>  6 files changed, 542 insertions(+), 0 deletions(-)
> 
Looks ok to me in general, but you really should rename the header to
sh_dac_audio.h or something similar, since dac_audio is an absurdly
generic name desite being tied entirely to the SH DAC.

Once you have fixed that up you should resend it and make sure to include
the ALSA folks, as they may have some comments on the actual audio bits.
