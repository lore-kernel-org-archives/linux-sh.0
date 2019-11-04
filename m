From: youling 257 <youling257@gmail.com>
Date: Mon, 04 Nov 2019 08:27:20 +0000
Subject: Re: ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
Message-Id: <CAOzgRdYTa-nAa7QV6c2aZs910BACg91vAjcjw4V-Oy8KCZVmmQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAOzgRdYSaaF6OkXGME2=fn1dfTbpyt_GqEs=10oXH=V6SudfyA@mail.gmail.com>
 <s5himo0cbmm.wl-tiwai@suse.de>
In-Reply-To: <s5himo0cbmm.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, gregkh@google.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-arm-kernel@lists.infradead.org

This driver https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/usb/gadget/function/f_audio_source.c

2019-11-04 16:02 GMT+08:00, Takashi Iwai <tiwai@suse.de>:

> Exactly which driver is hit?  The code path is via hw_support_mmap()
> and it's currently:
>
> static bool hw_support_mmap(struct snd_pcm_substream *substream)
> {
> 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
> 		return false;
>
> 	if (substream->ops->mmap ||
> 	    substream->dma_buffer.dev.type != SNDRV_DMA_TYPE_DEV)
> 		return true;
>
> 	return dma_can_mmap(substream->dma_buffer.dev.dev);
> }
>
> so at least the driver has already set the SNDRV_DMA_TYPE_DEV
> explicitly (it's non-zero) and some device object, but the device
> object was invalid for dma_can_mmap() call.
>
> This smells more like a driver-side issue, not in the core side.
>
>
> thanks,
>
> Takashi
>
