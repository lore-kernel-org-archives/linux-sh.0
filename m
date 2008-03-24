From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 24 Mar 2008 15:06:18 +0000
Subject: Re: [PATCH] 3/3 maple: update bus driver to support Dreamcast VMU
Message-Id: <1206371178.6283.37.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1206207805.6324.13.camel@localhost.localdomain>
	<1206209786.6324.41.camel@localhost.localdomain>
	<20080324033344.GB15872@linux-sh.org> <20080324144647.GC2899@logfs.org>
In-Reply-To: <20080324144647.GC2899@logfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, MTD <linux-mtd@lists.infradead.org>, dwmw2 <dwmw2@infradead.org>


On Mon, 2008-03-24 at 15:46 +0100, J=C3=B6rn Engel wrote:
> On Mon, 24 March 2008 12:33:44 +0900, Paul Mundt wrote:
> >=20
> > So here we have the same issue as in the previous patch, but with the
> > mutex API instead. The entire point of adding a comment for clarity is
> > that it becomes obvious what this is trying to accomplish, which it sti=
ll
> > isn't. Maple shouldn't require a supplemental document to detail its
> > locking strategy in a way that doesn't induce blindness.
> >=20
> > The mutex_unlock() here looks very suspicious. You first try to grab the
> > lock via the trylock, if it's contended, then you try to unlock it and
> > then grab it again for yourself before continuing on. This sort of
> > juggling looks really racy. Under what conditions will this lock be
> > contended, and under what conditions is it released? If you have a
> > transfer in place, you contend on the lock, and then this code suddenly
> > unlocks, what happens to your queue? It seems like you are trying to lo=
ck
> > down the mq for the duration of its lifetime, in addition to having a
> > separate list lock for guarding against the list getting mangled from
> > underneath you.


It would be contended if the initial (on boot) scans of the ports has
failed. This seems to happen when the bus has a lot of devices attached
eg all four ports and some subdevices.

A status command is queued but not processed, and the result is the
device remains locked and can never be accessed.

Here we check whether the queued status command for that port has been
processed. Then trylock - if we take the lock then great, process away,
if we cannot then the unlock the previously taken redundant lock and
reacquire the lock.

OK, it could just use trylock and not give a stuff about the result -
because all we want is a locked queue...but that didn't seem right.

> >=20
> > It looks like you are trying to roll your own complex queuing mechanism
> > in a fairly non-obvious fashion. Have you considered using things like
> > the block layer qeueing for dealing with a lot of this for you? This is
> > what we ended up using for OMAP mailboxes and it worked out pretty well
> > (arch/arm/plat-omap/mailbox.c) there.
> >=20
> > This sort of obscure locking is going to cause you nothing but trouble =
in
> > the long run.
>=20
> As a general rule, locks should be taken and released in the same
> function.  That allows the locking to be easily reviewed and errors
> are easy to spot for most readers.
>=20
> int foo(void)
> {
> 	int err;
>=20
> 	err =3D bar();
> 	if (err)
> 		return err;
> 	mutex_lock(&foo_lock);
> 	err =3D baz();
> 	if (err)
> 		return err;
> 	mutex_unlock(&foo_lock);
> 	return bumble();
> }
>=20
> In the above example, one doesn't have to think twice, the bugfix
> becomes almost mechanical.  But as soon as locks are taken in one
> function and released in another, things get hairy.
>=20
> int foo(void)
> {
> 	int err;
>=20
> 	err =3D bar();
> 	if (err)
> 		return err;
> 	mutex_lock(&foo_lock);
> 	err =3D baz();
> 	/* baz implicitly unlocks the mutex */
> 	if (err)
> 		return err;
> 	return bumble();
> }
>=20
> Even with the comment, one cannot be sure.
>=20
> int baz(void)
> {
> 	int err;
>=20
> 	err =3D bee();
> 	if (err)
> 		return err;
> 	mutex_unlock(&foo_lock);
> 	return boo();
> }
>=20
> One always has to check all functions involved.  If bee() returns an
> error, neither foo() nor baz() will unlock the mutex.  And after
> changing baz() to always unlock the mutex, one next needs to check all
> callers whether any of them unlock on errors.  Under some circumstances
> those would have been correct before, but not after.  Unless...
>=20
> In short, verifying the locking is about the least pleasurable thing to
> do once locks are taken and released in seperate functions.
>=20



I don't think I have any alternative here. The problem is that the bus
checks periodically (every HZ ticks but that could be changed) if a
device remains connected to the system by queueing a status command. (If
the status command is replied to with a "No response" then that
indicates to the bus that the device has been removed.

But if there is already a command queued for that device (eg a block
read or a block write) then all that would happen is that the commands
get corrupted and an oops ensures.

If I lock the queue for each device then that cannot happen - the bus
driver bounces the status query.

Maple reads and writes are asynchronous of the command being queued - so
the locks are freed when the maple processing is done (ie in another
function). However there is a common unlock point for them all.

