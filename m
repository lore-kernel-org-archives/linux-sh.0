From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 25 Sep 2013 21:19:04 +0000
Subject: Re: [PATCH] clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <52435348.30008@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1379534476-10901-1-git-send-email-horms+renesas@verge.net.au>
 <1379534476-10901-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1379534476-10901-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 09/18/2013 10:01 PM, Simon Horman wrote:
> From: Magnus Damm <damm@opensource.se>
>=20
> Update the STI driver by setting cpu_possible_mask to make EMEV2
> SMP work as expected together with the ARM broadcast timer.
>=20
> This breakage was introduced by:
>=20
> f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over rea=
l hardware clock-event
>=20
> Without this fix SMP operation is broken on EMEV2 since no
> broadcast timer interrupts trigger on the secondary CPU cores.
>=20
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

Thanks ! Applied to my tree as 3.12 fix.

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

