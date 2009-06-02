From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 02 Jun 2009 21:37:22 +0000
Subject: Re: [linux-pm] [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <20090602213722.GA1972@ucw.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi!


> > In the process of discussing a similar interface for OMAP, we dicussed
> > that having 3 states would be more useful. =A0Specifically, and
> > _enable(), _idle() and _disable() hook. =A0The _enable() and _idle()
> > hooks being exactly what you proposed above, but with the addition of
> > a _disable() hook which says not only can the device go idle, but that
> > the driver is really finished with the device. =A0In this case, more
> > aggresive PM measures could be taken, such as turning of regulators
> > that may have long latencies that may not be appropriate to turn off
> > in idle.
>=20
> Hm.. I wonder when the driver is really finished with the device
> though. Only when the module is unloaded? If so then we could deal
> with the hard disable using platform bus notifiers (like in [04/04]).

I'd guess that they call disable() when /dev node is closed... and
idle() when device is opened but inactive.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
