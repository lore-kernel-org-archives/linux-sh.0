From: Liam Girdwood <lrg@slimlogic.co.uk>
Date: Tue, 31 Aug 2010 09:57:06 +0000
Subject: Re: [alsa-devel] [PATCH 0/4 v2] Add FSI - HDMI support V2
Message-Id: <1283248626.3147.32.camel@odin>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux-SH <linux-sh@vger.kernel.org>

On Tue, 2010-08-31 at 14:45 +0900, Kuninori Morimoto wrote:
> Dear Mark, Paul
> 
> These are FSI - HDMI prototype sound support V2
> 
> Kuninori Morimoto (4):
>       fbdev: sh-mobile: Add HDMI sound type selection
>       ASoC: Add sh_mobile_hdmi sound support
>       ASoC: fsi-codec: Add FSI - HDMI support
>       ARM: mach-shmobile: ap4evb: Add HDMI sound support
> 
> >> Paul
> 1st patch is depend on 
> [PATCH] fbdev: sh-mobile_hdmi: remove un-necessity settings
> which I sent to LinuxSH ML in 2010/08/27
> 
> >> Mark
> 2nd, 3rd ASoC patches are based on Mark's "for-2.6.37"

ASoC parts:-

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

