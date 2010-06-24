From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Date: Thu, 24 Jun 2010 18:56:14 +0000
Subject: Re: [PATCH] mm: kmemleak: Change kmemleak default buffer size
Message-Id: <20100624185614.GA6031@tux>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTimb7rP0rS0OU8nan5uNEhHx_kEYL99ImZ3c8o0D@mail.gmail.com>
 <1277189909-16376-1-git-send-email-sankar.curiosity@gmail.com>
 <20100622165509.GB11336@tux>
 <AANLkTikHiPKPD5myvn8bycPAS4f9rBkPvbag6if7p23O@mail.gmail.com>
In-Reply-To: <AANLkTikHiPKPD5myvn8bycPAS4f9rBkPvbag6if7p23O@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sankar P <sankar.curiosity@gmail.com>
Cc: Luis Rodriguez <Luis.Rodriguez@Atheros.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lethal@linux-sh.org" <lethal@linux-sh.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "penberg@cs.helsinki.fi" <penberg@cs.helsinki.fi>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rnagarajan@novell.com" <rnagarajan@novell.com>, "teheo@novell.com" <teheo@novell.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>

On Thu, Jun 24, 2010 at 12:31:11AM -0700, Sankar P wrote:
> On Tue, Jun 22, 2010 at 10:25 PM, Luis R. Rodriguez
> <lrodriguez@atheros.com> wrote:
> > On Mon, Jun 21, 2010 at 11:58:29PM -0700, Sankar P wrote:
> >> If we try to find the memory leaks in kernel that is
> >> compiled with 'make defconfig', the default buffer size
> >> seem to be inadequate. Change the buffer size from
> >> 400 to 1000, which is sufficient in most cases.
> >>
> >> Signed-off-by: Sankar P <sankar.curiosity@gmail.com>
> >
> > What's your full name? Please read the "Developer's Certificate of Orig=
in 1.1"
> > It says:
> >
> > then you just add a line saying
> >
> > =A0 =A0 =A0 =A0Signed-off-by: Random J Developer <random@developer.exam=
ple.org>
> >
> > using your real name (sorry, no pseudonyms or anonymous contributions.)
> >
> >
> > Also you may want to post on a new thread instead of using this old thr=
ead
> > unless the maintainer is reading this and wants to pick it up.
> >
>=20
> In our part of the world, we dont have lastnames. We just use the
> first letter of our father's name as the last name.

Oh wow, what part of the world is that? Interesting.

> I will send the updated patch as a new mail, I thought it will be
> easier to follow if all mails belongs to the same thread.

It does help in-thread, but patches should be sent separately unless
you know for sure the maintainer *will* read this.

  Luis
