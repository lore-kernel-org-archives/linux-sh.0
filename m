From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 05 Aug 2013 10:44:34 +0000
Subject: Re: [GIT PULL 0/2 v2] Renesas ARM based SoC clocksource updates for v3.12
Message-Id: <51FF8212.5090406@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1375667799-6327-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1375667799-6327-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 08/05/2013 03:56 AM, Simon Horman wrote:
> Hi Daniel,
>=20
> please consider the following Renesas ARM based SoC clocksource updates
> for v3.12.
>=20
>=20
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec9300=
92:
>=20
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/re=
nesas-clocksource-for-v3.12
>=20
> for you to fetch changes up to 172705f8a40b6e72c53f8cceda079504ed71c4e0:
>=20
>   clocksource: em_sti: Convert to devm_* managed helpers (2013-08-05 10:4=
7:10 +0900)

Shall I pull your tree or applying the patches to my branch is ok also ?

Thanks
  -- Daniel

>=20
> ----------------------------------------------------------------
> Renesas ARM based SoC clocksource updates for v3.12
>=20
> * Add support for CMT hardware with 32-bit control and counter registers
> * em_sti: Convert to devm_* managed helpers
>=20
> ----------------------------------------------------------------
> Laurent Pinchart (1):
>       clocksource: em_sti: Convert to devm_* managed helpers
>=20
> Magnus Damm (1):
>       clocksource: sh_cmt: 32-bit control register support
>=20
>  drivers/clocksource/em_sti.c | 49 +++++++++++++-------------------------=
-----
>  drivers/clocksource/sh_cmt.c | 50 +++++++++++++++++++++++++++++++-------=
------
>  2 files changed, 50 insertions(+), 49 deletions(-)
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

