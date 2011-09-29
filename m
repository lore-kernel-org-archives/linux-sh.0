From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Thu, 29 Sep 2011 08:11:18 +0000
Subject: Re: [PATCH 3/3] PM / QoS: Add function dev_pm_qos_read_value() (v2)
Message-Id: <CAORVsuUopAWQuFkn1cURiv+YhEUT6=SQV5NRL5N1Y1oYn9d2NQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl>
	<201109242323.03474.rjw@sisk.pl>
	<201109242326.48485.rjw@sisk.pl>
In-Reply-To: <201109242326.48485.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, Ming Lei <tom.leiming@gmail.com>

Hi Rafael,

I have a few minor remarks, inlined below.

On Sat, Sep 24, 2011 at 11:26 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> To read the current PM QoS value for a given device we need to
> make sure that the device's power.constraints object won't be
> removed while we're doing that. =A0For this reason, put the
> operation under dev->power.lock and acquire the lock
> around the initialization and removal of power.constraints.
>
> Moreover, since we're using the value of power.constraints to
> determine whether or not the object is present, the
> power.constraints_state field isn't necessary any more and may be
> removed. =A0However, dev_pm_qos_add_request() needs to check if the
> device is being removed from the system before allocating a new
> PM QoS constraints object for it, so it has to use device_pm_lock()
> and the device PM QoS initialization and destruction should be done
> under device_pm_lock() as well.
It might be good to mention dev_pm_qos_mtx which is used internally by
the per-device PM QoS code.

>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Other then the minor remarks:
Acked-by: Jean Pihet <j-pihet@ti.com>

> ---
> =A0drivers/base/power/main.c | =A0 =A04 -
> =A0drivers/base/power/qos.c =A0| =A0168 ++++++++++++++++++++++++++-------=
-------------
> =A0include/linux/pm.h =A0 =A0 =A0 =A0| =A0 =A08 --
> =A0include/linux/pm_qos.h =A0 =A0| =A0 =A03
> =A04 files changed, 103 insertions(+), 80 deletions(-)
>
> Index: linux/drivers/base/power/qos.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux.orig/drivers/base/power/qos.c
> +++ linux/drivers/base/power/qos.c
...

>
> +static void __dev_pm_qos_constraints_init(struct device *dev)
I would change the name or add a comment stating that this is an
internal function which reinits the constraints field under the lock.

Thanks & regards,
Jean
