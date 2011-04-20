From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 20 Apr 2011 16:41:04 +0000
Subject: Re: [PATCH 0/2] Common struct clk implementation, v14
Message-Id: <alpine.LFD.2.02.1104201830500.3323@ionos>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323328-63488165-1303317666=:3323"
List-Id: <linux-sh.vger.kernel.org>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1302754859.2767.30.camel@pororo>
	<20110414100048.GB1611@n2100.arm.linux.org.uk>
	<1302776705.28876.113.camel@pasglop>
	<20110414103200.GF1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140751220.24613@xanadu.home>
	<20110414120904.GH1611@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104140920110.24613@xanadu.home>
	<20110414153813.GC6259@n2100.arm.linux.org.uk>
	<20110418105442.GB27864@linux-sh.org>
	<20110420142816.GZ31131@pengutronix.de>
In-Reply-To: <20110420142816.GZ31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-63488165-1303317666=:3323
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Apr 2011, Uwe Kleine-K=F6nig wrote:
> I declare this to be stable, so assuming people are OK with it, you can
> use that as a base to convert your platforms.

You declare that stable? Interesting.
=20
> There is a 2nd branch on that repository that also contains my RFC patch
> just sent to this list in case you want to test it.

Which is utter crap as I pointed out a few minutes ago.

Also that clk thing is neither stable nor complete. It's just designed
wrong.=20

As long as it does not handle nested clocks proper and by default w/o
your tasteless add ons, it's just moving the status quo of ARM into a
common infrastructure file.

Yes, that's probably better than not having common infrastructure at
all, but trying to build up conversions on that lot would be a
complete waste of time and resources. Simply because you need to
convert the already converted stuff another time.

Thanks,

	tglx
--8323328-63488165-1303317666=:3323--
