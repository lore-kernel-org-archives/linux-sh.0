From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Fri, 03 Sep 2010 19:33:09 +0000
Subject: Re: [BUG?] rename patch accepted with --dry-run, rejected without
Message-Id: <20100903193309.GC29821@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com> <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com> <20100903182323.GA17152@pengutronix.de> <20100903184351.GC2341@burratino> <20100903192907.GA2978@n2100.arm.linux.org.uk>
In-Reply-To: <20100903192907.GA2978@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-sh@vger.kernel.org, bug-patch@gnu.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, git@vger.kernel.org

Hey Russell,

On Fri, Sep 03, 2010 at 08:29:07PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 03, 2010 at 01:43:51PM -0500, Jonathan Nieder wrote:
> > Uwe Kleine-K=F6nig wrote:
> > > On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
> >=20
> > >> Using --dry-run is fine, but omitting dry-run gives me:
> > >>=20
> > >> ...
> > >> patching file arch/arm/common/clkdev.c
> > >> patching file arch/sh/include/asm/clkdev.h
> > >> Hunk #1 FAILED at 1.
> > >> Hunk #2 FAILED at 11.
> > >> 2 out of 2 hunks FAILED -- saving rejects to file
> > >> arch/sh/include/asm/clkdev.h.rej
> > >>=20
> > >> I guess this is caused by the last "renaming" hunk, see below.
> >=20
> > Yep, I can reproduce this.  Patch applies with "git apply",
> > "patch --dry-run -p1" accepts it, "patch -p1" fails.
>=20
> git patches include additional metadata for renaming files, which gnu pat=
ch
> will not understand.
>=20
> If you want GNU patch compatible diffs, don't use -C or -M when generating
> patches out of git.
Still GNU patch should then already fail in --dry-run mode.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
