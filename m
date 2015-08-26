From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 Aug 2015 07:33:39 +0000
Subject: Re: [PATCH 23/25 v7][RFC] Local: Hack: remove pm_sysrq_init
Message-Id: <CANqRtoTwk2FJDh9xG+pi5kO-RNoJC3=99JaaVWEPJthFQNz=0A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbc55siq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbc55siq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Aug 24, 2015 at 11:32 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
>
> In initial H3 environment, psci/pm/suspend is not supported.
> When primary cpu was booted, pm_sysrq_init() is not initialized.
> So remove this function as temporary fix.
>
> Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> ---
> v5 -> v7
>
>  - no change

Thanks for your patch. Is this really needed? I doubt that, but
usually code is included for a reason. =)

If the patch is still needed, may I propose that you temporarily
modify the defconfig to disable CONFIG_MAGIC_SYSRQ instead of
modifying core code?

Thanks,

/ magnus
