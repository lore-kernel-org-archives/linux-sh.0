From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 04 Nov 2009 03:13:09 +0000
Subject: Re: [PATCH] sh: add SuperH DAC audio driver for ALSA V4
Message-Id: <20091104031309.GD12841@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091103201627.GA31131@rafazurita.homelinux.net>
In-Reply-To: <20091103201627.GA31131@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rafael Ignacio Zurita <rizurita@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org

On Tue, Nov 03, 2009 at 05:16:27PM -0300, Rafael Ignacio Zurita wrote:
> This is a port of the sound/oss/sh_dac_audio.c driver.
> The driver uses an on-chip 8-bit D/A converter, which has a speaker connected
> to one of its channels, found in several ancient HP machines.
> For interrupts it uses a high-resolution timer (hrtimer).
> Tested on SH7709 based hp6xx (HP Jornada 680/690 and HP Palmtop 620lx/660lx).
>  
> Also, since OSS Emulation works, the old OSS sound/oss/sh_dac_audio.c driver
> would be obsolete soon, and it could be removed.
>  
> Changes since V3:
>  - renamed sound/sh/snd_sh_dac_audio.c to sound/sh/sh_dac_audio.c
>  
> Changes since V2:
>  - renamed include/sound/dac_audio.h to include/sound/sh_dac_audio.h
> 
> Changes since V1:
>  - moved the platform device code into board code.
>  - dropped dac_audio_sync(), since that code is not needed (it was inherited of
>    the old oss driver).
>  - rewrote the code with style problems.
> 
> Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>
