From: Greg Kroah-Hartman <gregkh@google.com>
Date: Mon, 04 Nov 2019 08:32:50 +0000
Subject: Re: ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
Message-Id: <60ee349a-1fe7-46f0-5161-1dcfcb6fbee9@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAOzgRdYSaaF6OkXGME2=fn1dfTbpyt_GqEs=10oXH=V6SudfyA@mail.gmail.com>
 <s5himo0cbmm.wl-tiwai@suse.de>
 <CAOzgRdYTa-nAa7QV6c2aZs910BACg91vAjcjw4V-Oy8KCZVmmQ@mail.gmail.com>
In-Reply-To: <CAOzgRdYTa-nAa7QV6c2aZs910BACg91vAjcjw4V-Oy8KCZVmmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: youling 257 <youling257@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-arm-kernel@lists.infradead.org

On 11/4/19 9:27 AM, youling 257 wrote:
 > This driver 
https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/usb/gadget/function/f_audio_source.c
 >

The driver is broken and needs to be fixed.  Please feel free to submit
patches to AOSP to do so as you can trigger this easily.

thanks,

greg k-h
