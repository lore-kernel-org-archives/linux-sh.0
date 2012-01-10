From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 10 Jan 2012 15:10:33 +0000
Subject: Re: [PATCH 09/11] mmc: sh_mobile_sdhi: do not manage PM clocks
Message-Id: <Pine.LNX.4.64.1201101607310.530@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
 <1325686636-23905-10-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoRqSFMmC4VySM-Aczd7AFxZrC8nzjPwaffa+=3VtWZK0g@mail.gmail.com>
In-Reply-To: <CANqRtoRqSFMmC4VySM-Aczd7AFxZrC8nzjPwaffa+=3VtWZK0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

Hi Magnus

On Fri, 6 Jan 2012, Magnus Damm wrote:

> Hi Guennadi,
>=20
> On Wed, Jan 4, 2012 at 11:17 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On ARM the same clock is used by the PM subsystem and by the driver
> > directly. This leads to the clock staying permanently on, independent of
> > the runtime PM state. This patch makes clock enable and disable calls in
> > the driver SuperH-specific.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > =A0drivers/mmc/host/sh_mobile_sdhi.c | =A0 =A06 ++++++
> > =A01 files changed, 6 insertions(+), 0 deletions(-)
>=20
> Thanks for your patch.
>=20
> >From my point of view there is very little difference between SH and
> SH-Mobile ARM, so I don't understand the special treatment. Also, is
> this change really needed for SH with your recent Runtime PM patches?
>=20
> I believe we need to make use of the clock framework to get the clock
> rate configuration in the SDHI driver. At the same time we want to
> stop the clock as frequently as possible. I believe we should disable
> and enable the clock together with the Runtime PM get/put operations -
> pretty much exactly like our I2C master driver does. The only problem
> is, while the clock is disabled the clock rate may be changed. So we
> need to be able to notify the MMC subsystem about the new clock rate.

It sounds a bit strange to me, that the clock frequency can change - I=20
don't think we take it into account in other drivers? But if this is=20
really the case, would something like this help in this case:

http://thread.gmane.org/gmane.linux.kernel.mmc/12110

> Any ideas on how to make this happen?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
