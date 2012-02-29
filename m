From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Wed, 29 Feb 2012 08:36:56 +0000
Subject: Re: [PATCH v6 5/9] ARM: davinci: Consolidate time keeping and irq enable
Message-Id: <CAORVsuUyOz3ZDr7iR50Qi-TiT+Ng_fUBJGJU19JpQsfe6ZpwHw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
 <1330485109-7327-6-git-send-email-rob.lee@linaro.org>
In-Reply-To: <1330485109-7327-6-git-send-email-rob.lee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Rob,

On Wed, Feb 29, 2012 at 4:11 AM, Robert Lee <rob.lee@linaro.org> wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> =A0arch/arm/mach-davinci/cpuidle.c | =A0 78 +++++++++++++++--------------=
---------
> =A01 files changed, 31 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpui=
dle.c
> index a30c7c5..6f457f1 100644
> --- a/arch/arm/mach-davinci/cpuidle.c
> +++ b/arch/arm/mach-davinci/cpuidle.c
...

> @@ -30,12 +31,42 @@ struct davinci_ops {
> =A0 =A0 =A0 =A0u32 flags;
> =A0};
>
> +/* Actual code that puts the SoC in different idle states */
> +static int davinci_enter_idle(struct cpuidle_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpui=
dle_driver *drv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 int index)
> +{
> + =A0 =A0 =A0 struct cpuidle_state_usage *state_usage =3D &dev->states_us=
age[index];
> + =A0 =A0 =A0 struct davinci_ops *ops =3D cpuidle_get_statedata(state_usa=
ge);
> +
> + =A0 =A0 =A0 if (ops && ops->enter)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops->enter(ops->flags);
> +
> + =A0 =A0 =A0 return cpuidle_wrap_enter(dev, =A0drv, index,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_sim=
ple_enter);
This does not look right since ops->exit will never be called.

> +
> + =A0 =A0 =A0 if (ops && ops->exit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops->exit(ops->flags);
> +
> + =A0 =A0 =A0 return index;
> +}
> +
...

Regards,
Jean
