From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 14 May 2009 20:55:34 +0000
Subject: Re: [PATCH] sh: remove old TMU driver
Message-Id: <20090514205534.GE9256@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090512102554.25836.30844.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090512102554.25836.30844.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 18:23 Thu 14 May     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 21:37 Thu 14 May     , Magnus Damm wrote:
> > Hi Jean-Christophe,
> >=20
> > On Thu, May 14, 2009 at 9:27 PM, Jean-Christophe PLAGNIOL-VILLARD
> > <plagnioj@jcrosoft.com> wrote:
> > > On 19:25 Tue 12 May =A0 =A0 , Magnus Damm wrote:
> > >> From: Magnus Damm <damm@igel.co.jp>
> > >>
> > >> This patch removes the old TMU driver (CONFIG_SH_TMU/timer-tmu.c)
> > >>
> > >> As replacement, select the sh_tmu driver with CONFIG_SH_TIMER_TMU
> > >> and configure timer channel using platform data.
> > >>
> > >> If multiple TMU channels are enabled using platform data, use the
> > >> earlytimer parameter on the kernel command line to select channel.
> > >> For instance, use "earlytimer=3Dsh_tmu.0" to select the first channe=
l.
> > >>
> > >> To verify which timer is being used, look at printouts or the timer
> > >> irq count in /proc/interrupts.
> > >>
> > >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > >> ---
> > > Is there a git where I can sync to have your patch set?
> > > I'd to test on the r2dplus (real hw and qemu)
> >=20
> > Latest sh-2.6.git tree has all the timer stuff merged. I've actually
> > already tested on r2d plus hardware a bit - one of my target platforms
> > - but more testing is always welcome. =3D)
> tks
>=20
> I want to known the qemu comportment too.
works fine on qemu r2dplus too

Best Regards,
J.
