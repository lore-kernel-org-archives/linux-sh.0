From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 12 Sep 2011 08:26:49 +0000
Subject: Re: [PATCH 2/5] PM / Runtime: Do not run callbacks under lock for
Message-Id: <CACVXFVPshpc-aVHGMYWkthffMRYLFh4BadnEAhf+eQ47CwWLZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl>
	<201108310020.26104.rjw@sisk.pl>
In-Reply-To: <201108310020.26104.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, jean.pihet@newoldbits.com

Hi,

On Wed, Aug 31, 2011 at 6:20 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The rpm_suspend() and rpm_resume() routines execute subsystem or PM
> domain callbacks under power.lock if power.irq_safe is set for the
> given device. =A0This is inconsistent with that rpm_idle() does after
> commit 02b2677 (PM / Runtime: Allow _put_sync() from
> interrupts-disabled context) and is problematic for subsystems and PM
> domains wanting to use power.lock for synchronization in their
> runtime PM callbacks. =A0For this reason, make runtime PM core functions
> always release power.lock before invoking subsystem or PM domain

If power.lock is released, the transition states(resuming or suspending)
may be observed in rpm_suspend or rpm_resume, then tasks schedule
will be produced in these two functions, so the functions below can't be

      pm_runtime_suspend()
      pm_runtime_autosuspend()
      pm_runtime_resume()
      pm_runtime_put_sync_suspend()
      pm_runtime_put_sync_autosuspend()

called in irq-off contexts safely even though irq_safe flag is set.

> callbacks.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =A0drivers/base/power/runtime.c | =A0 50 ++++++++++++++++++++++++--------=
-----------
> =A01 file changed, 28 insertions(+), 22 deletions(-)
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>


thanks,
--=20
Ming Lei
