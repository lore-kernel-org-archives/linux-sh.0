From: "Adrian McMenamin" <lkmladrian@gmail.com>
Date: Sun, 13 Jan 2008 18:24:34 +0000
Subject: Re: [PATCH] SH/Dreamcast - add support for GD-Rom CDROM drive on SEGA Dreamcast
Message-Id: <8b67d60801131024x4a128cdctdf958bdaa9f375ed@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1200007549.6349.16.camel@localhost.localdomain>
	 <1200088609.6213.3.camel@localhost.localdomain>
	 <20080112053630.0ccb290e.akpm@linux-foundation.org>
	 <1200147241.6207.17.camel@localhost.localdomain>
	 <20080112111520.abf625ce.akpm@linux-foundation.org>
In-Reply-To: <20080112111520.abf625ce.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, Jens Axboe <jens.axboe@oracle.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 12/01/2008, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat, 12 Jan 2008 14:14:01 +0000 Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:
>
> >
> > > > + spin_command->cmd[0] = 0x70;
> > > > + spin_command->cmd[2] = 0x1f;
> > > > + spin_command->buflen = 0;
> > > > + gd.pending = 1;
> > > > + gdrom_packetcommand(gd.cd_info, spin_command);
> > > > + /* 60 second timeout */
> > > > + wait_event_interruptible_timeout(command_queue, gd.pending = 0, HZ * 60);
> > > > + gd.pending = 0;
> > > > + kfree(spin_command);
> > > > + if (gd.status & 0x01) {
> > > > +         /* log an error */
> > > > +         gdrom_getsense(NULL);
> > > > +         return -EIO;
> > > > + }
> > > > + return 0;
> > > > +}
> > >
> > > If the wait_event_interruptible_timeout() indeed times out, we go ahead and
> > > free spin_command.  But someone else could potentially be using it.
> > >
> > > Suppose gdrom_packetcommand() got stuck for a minute due to bad hardware,
> > > or some SCHED_FIFO task preempting us here and running for 61 seconds without
> > > yielding or something similarly weird.
> > >
> >
> >
> > Maybe I am being stupid here, but I don't follow this. They'll get a
> > non-fatal error, that's all. Who else would be using spin_command? It's
> > just a series of bytes to plug into the GD Rom registers, that's all.
> >
>
> After programming the registers we need to wait for the interrupt to clear
> gd.pending, don't we?
>
> <looks>
>
> oh, I see.  gd is a global singleton and we only support one command at a
> time and one device.  hrm.
>

OK, at the risk of looking like a fool:

Yes, it does treat this as only one device per box as that's the way
the things are made.

The hardware will stop you from running two commands in parallel - the
device will be flagged as busy and so you won't be able to get it do
anything sensible. I have now added in some additional checks so that
a user cannot start another command before the old one finishes - but
I still don't see what the problem is with freeing the memory.

The variable is a local, and an automatic, not a global or a static,
so I don't see how kfree() could be releasing somebody else's lump of
memory anyway. Or have I missed something obvious?
