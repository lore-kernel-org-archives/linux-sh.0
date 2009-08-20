From: Jarkko Nikula <jhnikula@gmail.com>
Date: Thu, 20 Aug 2009 12:22:12 +0000
Subject: Re: [alsa-devel] [PATCH v2 1/4] Add SuperH FSI driver support for
Message-Id: <20090820152212.b8be38b9.jhnikula@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uy6ped79a.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uy6ped79a.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, broonie@opensource.wolfsonmicro.com, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org

Hi

On Thu, 20 Aug 2009 21:01:05 +0900
Kuninori Morimoto <morimoto.kuninori@renesas.com> wrote:

> This driver is very simple.
> It support playback only now.
> This patch is tested by ms7724se board.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> v1 -> v2
> 
> o it direct use clk_enable/disable
> o rename fsi.h -> sh_fsi.h
> 
>  include/sound/sh_fsi.h |   83 ++++
>  sound/soc/sh/Kconfig   |    7 +-
>  sound/soc/sh/Makefile  |    2 +
>  sound/soc/sh/fsi.c     | 1004 ++++++++++++++++++++++++++++++++++++++++++++++++

I'm not familiar with the SH but this arch specific header file
sh_fsi.h should go either into sound/soc/sh or if generic enough, then
somewhere under arch/sh/include/.


-- 
Jarkko
