From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 29 May 2009 13:45:32 +0000
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <Pine.LNX.4.44L0.0905290942150.2882-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30905290041p13cc3e48k3527640fb52c3730@mail.gmail.com>
In-Reply-To: <aec7e5c30905290041p13cc3e48k3527640fb52c3730@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org

On Fri, 29 May 2009, Magnus Damm wrote:

> > (And by the way, the _noirq ops don't run in atomic context. =A0They run
> > in process context with most interrupt deliveries disabled. =A0It's not
> > the same thing -- they are allowed to sleep.)
>=20
> Huh, so if they are allowed to sleep then clock events are still
> running. And probably some clocksource as well. I guess that's why you
> say "most" interrupts disabled instead of all. Sharing the timer IRQ
> is not allowed then?

Rafael can tell you.  But notice I didn't say the interrupts were
disabled -- I said that interrupt _delivery_ was disabled.  In general
the interrupts themselves _are_ enabled; the kernel fields them but
then does not call the drivers' interrupt handler routines.  (Except
perhaps for IRQs which are explicitly marked as wakeup sources...)

> I wonder if the PM code assumes that the clock event is a sys device?
> We use platform drivers for clock events on SuperH...

Ask Rafael.

Alan Stern

