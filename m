From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 Feb 2014 06:08:45 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: lager: add SDHI0/2 support
Message-Id: <CANqRtoT_pXwn_4=U5FpqYXri_rEas377zLO_6bpUE5DmH7Fd+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sirvb9to.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87sirvb9to.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Simon,

On Fri, Feb 7, 2014 at 5:34 PM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> SDHI0 (CN8) needs JP/SW settings
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for the patch, Morimoto-san.

I've now briefly tested this one on top of
renesas-devel-v3.14-rc1-20140207, and as long as the following Kconfig
entires are set then everything seems ok:

CONFIG_MMC_SDHI=y
CONFIG_REGULATOR_GPIO=y

I've tested boot-up and checking contents of /proc/partition and then
done a simple eject/insert test.

Not sure which ones that are appropriate:

Tested-by: Magnus Damm <damm@opensource.se>
Acked-by: Magnus Damm <damm@opensource.se>

Simon, can you please pick up this patch?

Thanks for your help.

Cheers,

/ magnus
