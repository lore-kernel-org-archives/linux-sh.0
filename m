From: Rob Lee <rob.lee@linaro.org>
Date: Mon, 27 Feb 2012 15:13:59 +0000
Subject: Re: [PATCH v5 2/9] SH: shmobile: cpuidle consolidation
Message-Id: <CAMXH7KHZH5wMHLOvhQe22K8+7s+yvCVtOvrNw0-ogjFArt-ZNQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330318063-25460-1-git-send-email-rob.lee@linaro.org>
 <1330318063-25460-3-git-send-email-rob.lee@linaro.org>
In-Reply-To: <1330318063-25460-3-git-send-email-rob.lee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Adding sh mailing list and sh contributors I missed on the original
submission.  SH folks, full patchset submission can be found here:
http://www.spinics.net/lists/arm-kernel/msg161596.html

Best Regards,
Rob

On Sun, Feb 26, 2012 at 10:47 PM, Robert Lee <rob.lee@linaro.org> wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> =A0arch/sh/kernel/cpu/shmobile/cpuidle.c | =A0 10 +++-------
> =A01 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/s=
hmobile/cpuidle.c
> index 6d62eb4..1ddc876 100644
> --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
> +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
> @@ -29,7 +29,6 @@ static int cpuidle_sleep_enter(struct cpuidle_device *d=
ev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int index)
> =A0{
> =A0 =A0 =A0 =A0unsigned long allowed_mode =3D SUSP_SH_SLEEP;
> - =A0 =A0 =A0 ktime_t before, after;
> =A0 =A0 =A0 =A0int requested_state =3D index;
> =A0 =A0 =A0 =A0int allowed_state;
> =A0 =A0 =A0 =A0int k;
> @@ -47,19 +46,16 @@ static int cpuidle_sleep_enter(struct cpuidle_device =
*dev,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0k =3D min_t(int, allowed_state, requested_state);
>
> - =A0 =A0 =A0 before =3D ktime_get();
> =A0 =A0 =A0 =A0sh_mobile_call_standby(cpuidle_mode[k]);
> - =A0 =A0 =A0 after =3D ktime_get();
> -
> - =A0 =A0 =A0 dev->last_residency =3D (int)ktime_to_ns(ktime_sub(after, b=
efore)) >> 10;
>
> =A0 =A0 =A0 =A0return k;
> =A0}
>
> =A0static struct cpuidle_device cpuidle_dev;
> =A0static struct cpuidle_driver cpuidle_driver =3D {
> - =A0 =A0 =A0 .name =3D =A0 =A0 =A0 =A0 "sh_idle",
> - =A0 =A0 =A0 .owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "sh_idle",
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .en_core_tk_irqen =A0 =A0 =A0 =3D 1,
> =A0};
>
> =A0void sh_mobile_setup_cpuidle(void)
> --
> 1.7.1
>
