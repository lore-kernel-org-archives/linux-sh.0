From: Lin Ming <minggr@gmail.com>
Date: Tue, 10 May 2011 08:22:00 +0000
Subject: Re: [PATCH 1/5] PM / Runtime: Support for generic I/O power domains (v3)
Message-Id: <BANLkTin49iSYn=r8G=L0S2vnZhtZw6RFpw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl>
	<201105082320.57185.rjw@sisk.pl>
	<201105082322.44268.rjw@sisk.pl>
In-Reply-To: <201105082322.44268.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Mon, May 9, 2011 at 5:22 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>

> +
> +/**
> + * __pm_genpd_restore_device - Restore a pre-suspend state of a device.
> + * @dev: Device to restore the state of.
> + * @genpd: Power domain the device belongs to.
> + */
> +static void __pm_genpd_restore_device(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct generic_power_domain *genpd)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> +
> + =A0 =A0 =A0 if (genpd->start_device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 genpd->start_device(dev);
> +
> + =A0 =A0 =A0 if (drv && drv->pm && drv->pm->runtime_resume)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->pm->runtime_resume(dev);
> +
> + =A0 =A0 =A0 if (genpd->stop_device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 genpd->stop_device(dev);
> +}

Why call ->stop_device in restore function?

BTW,
you implemented power domains for ARM / shmobile,
What can we do for other arches?
I wonder how to implement this "power domain" on x86.

Thanks,
Lin Ming
