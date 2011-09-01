From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Thu, 01 Sep 2011 15:17:51 +0000
Subject: Re: [RFC][PATCH 5/5] PM / Domains: Add default power off governor function
Message-Id: <CAORVsuW7rFEN8u7RCpmWJamtG2iUbA_zz3ax4hgBjGAZW9vU=A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl>
	<201108310022.43850.rjw@sisk.pl>
In-Reply-To: <201108310022.43850.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>

Rafael,

On Wed, Aug 31, 2011 at 12:22 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Add a function deciding whether or not a given PM domain should
> be powered off on the basis of that domain's devices' PM QoS
> constraints.
>
> ---
> =A0drivers/base/power/domain_governor.c | =A0 96 ++++++++++++++++++++++++=
+++++++++++
> =A0include/linux/pm_domain.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++
> =A02 files changed, 103 insertions(+)
>
> Index: linux/include/linux/pm_domain.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux.orig/include/linux/pm_domain.h
> +++ linux/include/linux/pm_domain.h
> @@ -49,6 +49,10 @@ struct generic_pm_domain {
> =A0 =A0 =A0 =A0int (*start_device)(struct device *dev);
> =A0 =A0 =A0 =A0int (*stop_device)(struct device *dev);
> =A0 =A0 =A0 =A0bool (*active_wakeup)(struct device *dev);
> + =A0 =A0 =A0 ktime_t power_off_latency;
> + =A0 =A0 =A0 ktime_t power_on_latency;
> + =A0 =A0 =A0 s64 break_even_ns;
> + =A0 =A0 =A0 s64 min_delta_ns;
How are those values populated? Is there a mechanism that dynamically
updates the values?

> =A0};
>
> =A0static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_doma=
in *pd)
> @@ -64,6 +68,9 @@ struct gpd_link {
> =A0};
>
> =A0struct gpd_gov_dev_data {
> + =A0 =A0 =A0 ktime_t start_latency;
> + =A0 =A0 =A0 ktime_t suspend_latency;
> + =A0 =A0 =A0 ktime_t resume_latency;
Same question here.

> =A0 =A0 =A0 =A0s64 break_even_ns;
> =A0};
>
...

Regards,
Jean
