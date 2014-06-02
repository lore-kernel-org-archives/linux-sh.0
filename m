From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Mon, 02 Jun 2014 08:58:39 +0000
Subject: Re: [PATCH 3/7] ARM: shmobile: Disable DVS support for r8a7790
Message-Id: <538C3CBF.1000206@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E66D.3020502@bp.renesas.com>
In-Reply-To: <5386E66D.3020502@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Benoit

Thank you for your feedback.

> Indeed, the line "cpu0-supply = <&vdd_dvfs>;" does just provide the name of the power rail that supply the ca15 cluster.
>
> The postfix _dvfs is a little bit misleading in this case, I do agree.
>
> If you do no want voltage scaling, it is just a matter of keeping the same voltage in the OPP table. This is what I have done in the series I sent a while back.
>
When I tested, the voltage scaling is not disabled with only 
voltage setting of OPP table. The regulator side(da9210) must
also be set to the same voltage.
(When voltage scaling is activated, the environment will be unstable.)

I will post the fixed patch later.

> That being said, what is the exact voltage range supported by the CPU?
> AFAIR, with 28nm process some SoCs are able to scale down to 0.9v.
>

I do not have this information.


