From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 Mar 2008 19:57:34 +0000
Subject: Re: [PATCH] i2c: SuperH Mobile I2C Bus Controller V4
Message-Id: <20080329205734.7a630e50@hyperion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20080328093530.32474.78684.sendpatchset@rx1.opensource.se>
	<20080329175732.GA9638@fluff.org.uk>
In-Reply-To: <20080329175732.GA9638-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Ben, Magnus, Paul,

This is Ben's first review as the new i2c subsystem co-maintainer. I
will just make a couple of comments on top of that to clarify a few
things. Thanks _a lot_ Ben for stepping in and doing that work :)

On Sat, 29 Mar 2008 17:57:32 +0000, Ben Dooks wrote:
> On Fri, Mar 28, 2008 at 06:35:30PM +0900, Magnus Damm wrote:
> > This is V4 of the SuperH Mobile I2C Controller Driver. A simple Master
> > only driver for the I2C block included in processors such as sh7343,
> > sh7722 and sh7723. Tested on a sh7722 MigoR using a rs5c732b rtc.
> >=20
> > Changes since V3:
> >  - Added SUPERH Kconfig dependency
> >  - Use spin_lock_irqsave() and spin_unlock_irqrestore()
> >  - Use IRQF_DISABLED
> >  - Checkpatch fixes
> > Changes since V2:
> >  - dev_xxx() use
> >  - Kill off superfluous ioarea resource
> >  - Add SMBus emulation
> > Changes since V1:
> >  - Use clk_get()/clk_put()/clk_get_rate() to get peripheral clock rate.
> >  - Use pdev->dev.bus_id instead of dev->name
>=20
> Do we really need these in the change message, we tend to assume that
> the changes before submission aren't really relevant. I would advise
> on removing these.

In fact the right place for these (useful) temporary changelog entries
is before the diffstat, right below, so that the reviewers can see them,
but they don't go in git.

> > Verified with the rtc-rs5c372 SMBus conversion patches currently in -mm.
> >=20
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> > ---
> >=20
> >  drivers/i2c/busses/Kconfig         |   10=20
> >  drivers/i2c/busses/Makefile        |    1=20
> >  drivers/i2c/busses/i2c-sh_mobile.c |  498 ++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 509 insertions(+)
> >=20
> > --- 0001/drivers/i2c/busses/Kconfig
> > +++ work/drivers/i2c/busses/Kconfig	2008-03-28 16:45:42.000000000 +0900
> > (...)

> (...)
> IIRC, the error for not receiving an ACK is -ECONNREFUSED when
> transfering data and -EREMOTEIO when sending the device address,
> and you should also check the message flags appropriately for
> I2C_M_IGNORE_ACK.

Actually not. I2C_M_IGNORE_ACK's implementation is purely optional, and
as this is a violation of the I2C standard, the less implemented it
gets, the happier I am.

> > (...)
> > +	/* Calculate the value for iccl. From the data sheet:
> > +	 * iccl =3D (p clock =F7 transfer rate) =D7 (L =F7 (L + H))
> > +	 * where L and H are the SCL low/high ratio (5/4 in this case).
> > +	 * We also round off the result.
> > +	 */
>=20
> there are some weird encoding characters in this message, making it
> difficult to work out what is going on here.

I totally second this. Please stick to ASCII as much as possible, it's
way easier for everyone.

Thanks,
--=20
Jean Delvare
