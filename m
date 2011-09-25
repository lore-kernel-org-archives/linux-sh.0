From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 25 Sep 2011 08:24:16 +0000
Subject: Re: [PATCH 2/3] PM / Runtime: Don't run callbacks under lock for
Message-Id: <CACVXFVPvbrWvC3TWL-SVfbdYxZcDWGQTj3vw6Z1+10KK=bv5ug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl>
	<201109242323.03474.rjw@sisk.pl>
	<201109242325.53563.rjw@sisk.pl>
In-Reply-To: <201109242325.53563.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

On Sun, Sep 25, 2011 at 5:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The rpm_suspend() and rpm_resume() routines execute subsystem or PM
> domain callbacks under power.lock if power.irq_safe is set for the
> given device. =A0This is inconsistent with that rpm_idle() does after
> commit 02b2677 (PM / Runtime: Allow _put_sync() from
> interrupts-disabled context) and is problematic for subsystems and PM
> domains wanting to use power.lock for synchronization in their
> runtime PM callbacks.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

> ---
> =A0drivers/base/power/runtime.c | =A0 68 +++++++++++++++++++++++++++++---=
-----------
> =A01 file changed, 46 insertions(+), 22 deletions(-)
>
> Index: linux/drivers/base/power/runtime.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux.orig/drivers/base/power/runtime.c
> +++ linux/drivers/base/power/runtime.c
> @@ -155,6 +155,31 @@ static int rpm_check_suspend_allowed(str
> =A0}
>
> =A0/**
> + * __rpm_callback - Run a given runtime PM callback for a given device.
> + * @cb: Runtime PM callback to run.
> + * @dev: Device to run the callback for.
> + */
> +static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
> + =A0 =A0 =A0 __releases(&dev->power.lock) __acquires(&dev->power.lock)
> +{
> + =A0 =A0 =A0 int retval;
> +
> + =A0 =A0 =A0 if (dev->power.irq_safe)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&dev->power.lock);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
> +
> + =A0 =A0 =A0 retval =3D cb(dev);
> +
> + =A0 =A0 =A0 if (dev->power.irq_safe)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&dev->power.lock);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> +/**
> =A0* rpm_idle - Notify device bus type if the device can be suspended.
> =A0* @dev: Device to notify the bus type about.
> =A0* @rpmflags: Flag bits.
> @@ -225,19 +250,8 @@ static int rpm_idle(struct device *dev,
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0callback =3D NULL;
>
> - =A0 =A0 =A0 if (callback) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->power.irq_safe)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&dev->power.loc=
k);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power=
.lock);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 callback(dev);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->power.irq_safe)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&dev->power.lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.l=
ock);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (callback)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __rpm_callback(callback, dev);
>
> =A0 =A0 =A0 =A0dev->power.idle_notification =3D false;
> =A0 =A0 =A0 =A0wake_up_all(&dev->power.wait_queue);
> @@ -252,22 +266,14 @@ static int rpm_idle(struct device *dev,
> =A0* @dev: Device to run the callback for.
> =A0*/
> =A0static int rpm_callback(int (*cb)(struct device *), struct device *dev)
> - =A0 =A0 =A0 __releases(&dev->power.lock) __acquires(&dev->power.lock)
> =A0{
> =A0 =A0 =A0 =A0int retval;
>
> =A0 =A0 =A0 =A0if (!cb)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOSYS;
>
> - =A0 =A0 =A0 if (dev->power.irq_safe) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D cb(dev);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D cb(dev);
> + =A0 =A0 =A0 retval =3D __rpm_callback(cb, dev);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> - =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0dev->power.runtime_error =3D retval;
> =A0 =A0 =A0 =A0return retval !=3D -EACCES ? retval : -EIO;
> =A0}
> @@ -347,6 +353,15 @@ static int rpm_suspend(struct device *de
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->power.irq_safe) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&dev->power.loc=
k);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&dev->power.lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto repeat;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Wait for the other suspend running in p=
arallel with us. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (;;) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prepare_to_wait(&dev->powe=
r.wait_queue, &wait,
> @@ -496,6 +511,15 @@ static int rpm_resume(struct device *dev
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->power.irq_safe) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&dev->power.loc=
k);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&dev->power.lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto repeat;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Wait for the operation carried out in p=
arallel with us. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (;;) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prepare_to_wait(&dev->powe=
r.wait_queue, &wait,
>
>


thanks,
--=20
Ming Lei
