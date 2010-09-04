From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Sep 2010 00:03:48 +0000
Subject: Re: [BUG?] rename patch accepted with --dry-run, rejected without
Message-Id: <20100904000348.GA7498@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com> <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com> <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com> <20100903182323.GA17152@pengutronix.de> <20100903184351.GC2341@burratino> <20100903192907.GA2978@n2100.arm.linux.org.uk> <20100903193309.GC29821@pengutronix.de>
In-Reply-To: <20100903193309.GC29821@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-sh@vger.kernel.org, bug-patch@gnu.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, git@vger.kernel.org

On Fri, Sep 03, 2010 at 09:33:09PM +0200, Uwe Kleine-K=F6nig wrote:
> > git patches include additional metadata for renaming files, which gnu p=
atch
> > will not understand.
> >=20
> > If you want GNU patch compatible diffs, don't use -C or -M when generat=
ing
> > patches out of git.
> Still GNU patch should then already fail in --dry-run mode.

And now look at the patch - it touches arch/sh/include/asm/clkdev.h twice.
Once to remove it and once as a rename.

GNU patch not in --dry-run mode will first remove arch/sh/include/asm/clkde=
v.h,
and then not have a file to deal with when it tries to patch the rename
part.  Whereas with --dry-run, the file stays around.

As I say, it's because GNU patch doesn't (currently) understand GIT
patches.  I wouldn't call that a bug in GNU patch.
