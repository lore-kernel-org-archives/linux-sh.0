From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Wed, 29 Feb 2012 08:30:59 +0000
Subject: Re: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
Message-Id: <CAORVsuX3nJAgbDY+oNQ+OD6xeZt=OkhK4n769Y+xJb0NXcrBmw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
 <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
In-Reply-To: <1330485109-7327-2-git-send-email-rob.lee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Rob,

On Wed, Feb 29, 2012 at 4:11 AM, Robert Lee <rob.lee@linaro.org> wrote:
> Make necessary changes to implement time keeping and irq enabling
> in the core cpuidle code. =A0This will allow the removal of these
> functionalities from various platform cpuidle implementations whose
> timekeeping and irq enabling follows the form in this common code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> =A0arch/arm/include/asm/cpuidle.h | =A0 14 ++++++
> =A0drivers/cpuidle/cpuidle.c =A0 =A0 =A0| =A0 90 ++++++++++++++++++++++++=
++++++++--------
> =A0include/linux/cpuidle.h =A0 =A0 =A0 =A0| =A0 13 ++++++
> =A03 files changed, 99 insertions(+), 18 deletions(-)
> =A0create mode 100644 arch/arm/include/asm/cpuidle.h
>
...

> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 59f4261..00b02f5 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
...

> @@ -110,7 +126,8 @@ int cpuidle_idle_call(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->states_usage[entered_state].time +> =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned lo=
ng long)dev->last_residency;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->states_usage[entered_state].usage++;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->last_residency =3D 0;
Braces are required here, according to the coding style doc.

...

Regards,
Jean
