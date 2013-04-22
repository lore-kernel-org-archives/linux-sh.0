From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 22 Apr 2013 13:50:50 +0000
Subject: Re: [PATCH v3] irqchip: Add support for ARMv7-M's NVIC
Message-Id: <alpine.LFD.2.02.1304221519221.21884@ionos>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-1473770335-1366637420=:21884"
List-Id: <linux-sh.vger.kernel.org>
References: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130419150927.GE15233@pengutronix.de>
 <20130422100219.GH15233@pengutronix.de> <201304221404.31281.arnd@arndb.de>
In-Reply-To: <201304221404.31281.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1473770335-1366637420=:21884
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-ID: <alpine.LFD.2.02.1304221532011.21884@ionos>

On Mon, 22 Apr 2013, Arnd Bergmann wrote:
> On Monday 22 April 2013, Uwe Kleine-K=F6nig wrote:
> > For the uncommented files using %32 instead of -gc->irq_base should
> > work.
>=20
> I'm not sure I understand why this doesn't work for the ones that use
> a base that isn't a multiple of 32. Since you are masking the hwirq
> rather than the irq number, it will still be zero-based, won't it?

The issue is that for anything which uses this w/o irq domains
d->hwirq is 0.

Thanks,

	tglx


--8323328-1473770335-1366637420=:21884--
