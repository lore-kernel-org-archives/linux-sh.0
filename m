From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 03 Sep 2010 19:29:07 +0000
Subject: Re: [BUG?] rename patch accepted with --dry-run, rejected without
Message-Id: <20100903192907.GA2978@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com> <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com> <20100903182323.GA17152@pengutronix.de> <20100903184351.GC2341@burratino>
In-Reply-To: <20100903184351.GC2341@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, bug-patch@gnu.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, git@vger.kernel.org

On Fri, Sep 03, 2010 at 01:43:51PM -0500, Jonathan Nieder wrote:
> (+cc: bug-patch)
>=20
> Hi,
>=20
> Uwe Kleine-K=F6nig wrote:
> > On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:
>=20
> >> Using --dry-run is fine, but omitting dry-run gives me:
> >>=20
> >> ...
> >> patching file arch/arm/common/clkdev.c
> >> patching file arch/sh/include/asm/clkdev.h
> >> Hunk #1 FAILED at 1.
> >> Hunk #2 FAILED at 11.
> >> 2 out of 2 hunks FAILED -- saving rejects to file
> >> arch/sh/include/asm/clkdev.h.rej
> >>=20
> >> I guess this is caused by the last "renaming" hunk, see below.
>=20
> Yep, I can reproduce this.  Patch applies with "git apply",
> "patch --dry-run -p1" accepts it, "patch -p1" fails.

git patches include additional metadata for renaming files, which gnu patch
will not understand.

If you want GNU patch compatible diffs, don't use -C or -M when generating
patches out of git.
