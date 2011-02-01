From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Tue, 01 Feb 2011 20:06:09 +0000
Subject: Re: Locking in the clk API, part 2: clk_prepare/clk_unprepare
Message-Id: <alpine.LFD.2.00.1102011503550.8580@xanadu.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-845050105-1296590771=:8580"
List-Id: <linux-sh.vger.kernel.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<20110201155344.GF1147@pengutronix.de>
	<20110201170637.GR31216@n2100.arm.linux.org.uk>
	<20110201193201.GH1147@pengutronix.de>
In-Reply-To: <20110201193201.GH1147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-845050105-1296590771=:8580
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Feb 2011, Uwe Kleine-K=F6nig wrote:

> My motivation for a more complicated clk_prepare was to make clk_prepare
> atomic when that's possible (i.e. when the clk is already prepared) and
> call it before the enable callback in clk_enable.  Then everything
> behaves nicely even if clk_enable is called from atomic context provided
> that the clock was prepared before (or doesn't need to).

NOOOOOOOOO!!!

We _do_ want drivers to _always_ call clk_prepare() in sleepable=20
context, and _then_ always call clk_enable() in whatever context they=20
wish.  Period.


Nicolas
--8323328-845050105-1296590771=:8580--
