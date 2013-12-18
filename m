From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 18 Dec 2013 15:38:35 +0000
Subject: Re: [PATCH v5 00/03] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits
Message-Id: <52B1C17B.6060500@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20131217101212.17491.56898.sendpatchset@w520>
In-Reply-To: <20131217101212.17491.56898.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Cc: khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, john.stultz@linaro.org, olof@lixom.net, tglx@linutronix.de

On 12/17/2013 11:12 AM, Magnus Damm wrote:
> clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits (v5)
>
> [PATCH v5 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and =
STI
> [PATCH v5 02/03] ARM: shmobile: Remove CMT, TMU and STI Kconfig entries
> [PATCH v5 03/03] sh: Remove Kconfig entries for TMU, CMT and MTU2
>
> This is V5 of the SH and ARM mach-shmobile clocksource Kconfig
> consolidation series.
>
> By sharing Kconfig entires in drivers/clocksource/Kconfig we
> can get rid of duplicated bits that do not belong under arch/.
>
> With this series applied it is possible to build the timer
> drivers for CMT, MTU2, TMU and STI in case of SH or ARM. The timer
> drivers are automatically selected by default. It is also possible
> to select and/or deselect freely when COMPILE_TEST has been selected.
>
> Many thanks to Olof, John, Daniel and Arnd for feedback!
>
> Changes since V4:
>   - Use SYS_SUPPORTS_SH/EM to avoid name space pollution, thanks Olof!
>   - Remove old SH entries for SYS_SUPPORTS_xxx, use above SH prefix inste=
ad
>
> Changes since V3:
>   - Updated patch 1/3 with more detailed help texts
>   - Updated patch 2/3 to fit latest renesas-devel tag, see below
>   - Included acks from John Stultz for patch 2/3 and 3/3
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>   Written against renesas.git tag renesas-devel-v3.13-rc3-20131214v2

Do you want me to take the patchset ? If so, could you respin it against=20
timers/core ?

Thanks
   -- Daniel

>
>   arch/arm/mach-shmobile/Kconfig |   35 ++++++++----------
>   arch/sh/Kconfig                |   76 ++++++++++++---------------------=
-------
>   drivers/clocksource/Kconfig    |   44 +++++++++++++++++++++++
>   3 files changed, 84 insertions(+), 71 deletions(-)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

