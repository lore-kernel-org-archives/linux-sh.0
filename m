From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 May 2014 08:09:17 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: Enable CPU FREQ support
Message-Id: <87y4xlc8gj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E64B.7060202@bp.renesas.com>
In-Reply-To: <5386E64B.7060202@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Inami-san

> Benoit Cousson (2):
>   ARM: dts: r8a7790-lager: Add DVFS parameters into cpu0 node for
>     r8a7790
>   ARM: shmobile: Make r8a77900 CPUFreq capable

According to this, [1/7] [2/7] patches were
created by Benoit ?

Maybe you want to add extra "From" to these patches,
and I guess you want to add your Signed-off-by also ?
Otherwise, patch author will be you instead of Benoit

like this ?

-----------------------
    From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
    Subject: [PATCH 2/7] ARM: shmobile: Make r8a77900 CPUFreq capable

=>  From: Benoit Cousson <bcousson@baylibre.com>

    Mark r8a77900 platform as CPUFreq capable
    on multiplatform build only.

=>  Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
    Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
    ---
    ...

