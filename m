From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 00:31:40 +0000
Subject: Re: [PATCH] sh: add SuperH DAC audio driver for ALSA V3
Message-Id: <20091026003140.GB6108@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091022202506.GA24298@rafazurita.homelinux.net>
In-Reply-To: <20091022202506.GA24298@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rafael Ignacio Zurita <rizurita@yahoo.com>
Cc: linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org

On Thu, Oct 22, 2009 at 05:25:06PM -0300, Rafael Ignacio Zurita wrote:
> This is a port of the sound/oss/sh_dac_audio.c driver.
> The driver uses an on-chip 8-bit D/A converter, which has a speaker connected
> to one of its channels, found in several ancient HP machines.
> For interrupts it uses a high-resolution timer (hrtimer).
> Tested on SH7709 based hp6xx (HP Jornada 680/690 and HP Palmtop 620lx/660lx).
>  
> Also, since OSS Emulation works, the old OSS sound/oss/sh_dac_audio.c driver
> would be obsolete soon, and it could be removed.
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

As I've already reviewed the first 2 versions, this one is fine with me,
especially since it lets us kill off the old OSS driver.  Hopefully
someone from the ALSA side can comment on the non-architecture/platform
bits.

Reviewed-by: Paul Mundt <lethal@linux-sh.org>
