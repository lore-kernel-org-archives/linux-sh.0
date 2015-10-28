From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 28 Oct 2015 09:22:09 +0000
Subject: Re: [PATCH] clocksource: sh_mtu2: Fix multiple shutdown call issue
Message-Id: <563093C1.5060400@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20151028014323.29894.70699.sendpatchset@little-apple>
In-Reply-To: <20151028014323.29894.70699.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, chris.brandt@renesas.com, horms+renesas@verge.net.au, tglx@linutronix.de

On 10/28/2015 02:43 AM, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> On the r7s72100 Genmai board the MTU2 driver currently triggers a common
> clock framework WARN_ON(enable_count) when disabling the clock due to
> the MTU2 driver after recent callback rework may call ->set_state_shutdow=
n()
> multiple times. A similar issue was spotted for the TMU driver and fixed =
in:
> 452b132 clocksource/drivers/sh_tmu: Fix traceback spotted in -next
>
> On r7s72100 Genmai v4.3-rc7 built with shmobile_defconfig spits out the
> following during boot:
>
> sh_mtu2 fcff0000.timer: ch0: used for clock events

Applied.

Thanks !

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

