From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 31 Jul 2013 07:35:53 +0000
Subject: Re: [PATCH] sh: kernel: cpu: provide 'NULL' parameter for calling cpuidle_register().
Message-Id: <51F8BE59.4030506@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <51F8BB73.2070603@asianux.com>
In-Reply-To: <51F8BB73.2070603@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 07/31/2013 09:23 AM, Chen Gang wrote:
> Need provide additional parameter for calling cpuidle_register() just
> like some of another architectures have done, or can not pass compiling.
>=20
> The related error (with kfr2r09_defconfig):
>=20
>     CC      arch/sh/kernel/cpu/shmobile/cpuidle.o
>   arch/sh/kernel/cpu/shmobile/cpuidle.c: In function 'sh_mobile_setup_cpu=
idle':
>   arch/sh/kernel/cpu/shmobile/cpuidle.c:102:2: error: too few arguments t=
o function 'cpuidle_register'
>     return cpuidle_register(&cpuidle_driver);
>     ^
>   In file included from arch/sh/kernel/cpu/shmobile/cpuidle.c:16:0:
>   include/linux/cpuidle.h:130:12: note: declared here
>    extern int cpuidle_register(struct cpuidle_driver *drv,
>             ^
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---

Thanks for the patch.

I have the same fix in my tree sent by Geert Uytterhoeven

  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

