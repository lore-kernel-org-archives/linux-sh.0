From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jun 2012 09:52:40 +0000
Subject: Re: [PATCH 17/27] ARM: shmobile: armadillo800eva: enable HDMI
Message-Id: <87hauip44b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5nupkl5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5nupkl5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > This patch enable HDMI support on CON3.
> > And removed unnecessary CONFIG_SYSFS_DEPRECATED_xxx config.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> I have tested that with this patch applied the kernel detects HDMI hardware.
> 
> sh-mobile-hdmi sh-mobile-hdmi: Detected HDMI controller 0x1:0xd5
> sh-mobile-hdmi sh-mobile-hdmi: SH Mobile HDMI Audio Codec
> asoc: sh_mobile_hdmi-hifi <-> fsib-dai mapping ok
>   #1: FSI2B-HDMI
> 
> However, I am not sure what if any testing I can perform using,
> for example speaker-test.
> 
> Unfortunately I don't have an HDMI device to hook up to the board.

Armadillo800eva is supporting HDMI (video output) and FSI-HDMI (sound output).
Above detect is for FSI-HDMI sound.

Test needs HDMI device.
If your armadillo was connected to HDMI device,
you can use
aplay -D hw:1 xxxx.wav
for HDMI sound test.

Best regards
---
Kuninori Morimoto
