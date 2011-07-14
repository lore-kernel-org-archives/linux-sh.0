From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Jul 2011 02:10:40 +0000
Subject: Re: [PATCH 0/3] PM / Domains / shmobile fixes
Message-Id: <CANqRtoTLO=DqehwanGdE+rgxL_ofa5YCJjsx47doHzwZDP4Ocw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201107132352.59801.rjw@sisk.pl>
In-Reply-To: <201107132352.59801.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Thu, Jul 14, 2011 at 6:52 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> The following three patches fix a couple of issues in the code currently
> in my pm-domains branch at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-d=
omains
>
> [1/3] - Use genpd_queue_power_off_work() for queuing up the powering off
> =A0 =A0 =A0 =A0of A4LC (this avoids attempting to queue up a work item wh=
ile it is
> =A0 =A0 =A0 =A0pending).
>
> [2/3] - Make the generic PM domains code react to -EBUSY returned from a
> =A0 =A0 =A0 =A0PM domain's .power_down() callback (needed for [3/3]).
>
> [3/3] - Return -EBUSY from the A4LC's .power_down() callback to indicate =
that
> =A0 =A0 =A0 =A0the domain hasn't been powered down on purpose and remove =
the confusing
> =A0 =A0 =A0 =A0(and now redundant) pm_genpd_poweron(A4LC) from pd_power_d=
own_a3rv().

All patches above look great, thanks a lot for your help!

Acked-by: Magnus Damm <damm@opensource.se>
