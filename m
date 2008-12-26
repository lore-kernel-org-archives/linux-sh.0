From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Fri, 26 Dec 2008 19:08:39 +0000
Subject: Re: [PATCH] sh: maple: add support for Maple controller as a
Message-Id: <1230318519.12447.1.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1229728542.1441.6.camel@localhost.localdomain>
	 <20081222150636.8dc20d61.akpm@linux-foundation.org>
	 <1229994455.22856.61.camel@brick>
	 <20081223085946.GA14302@anvil.corenet.prv>
In-Reply-To: <20081223085946.GA14302@anvil.corenet.prv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org

On Tue, 2008-12-23 at 03:59 -0500, Dmitry Torokhov wrote:
> On Mon, Dec 22, 2008 at 05:07:35PM -0800, Harvey Harrison wrote:
> > On Mon, 2008-12-22 at 15:06 -0800, Andrew Morton wrote:
> > > On Fri, 19 Dec 2008 23:15:42 +0000
> > > Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:
> > > 
> > > > Not sure what happened with earlier submissions, so here is an up-to-date
> > > > patch for the Dreamcast Maple controlled.
> > > > 
> > > > 
> > > > Add support for the SEGA Dreamcast Maple controller as a joystick
> > > > 
> > > > ...
> > > >
> > > > +static void dc_pad_callback(struct mapleq *mq)
> > > > +{
> > > > +	unsigned short buttons;
> > > > +	struct maple_device *mapledev = mq->dev;
> > > > +	struct dc_pad *pad = maple_get_drvdata(mapledev);
> > > > +	struct input_dev *dev = pad->dev;
> > > > +	unsigned char *res = mq->recvbuf;
> > > > +
> > > > +	buttons = ~cpu_to_le16(*(unsigned short *)(res + 8));
> > > 
> > > hm, could that be simplified?
> > 
> > And as a bonus fix the obvious sparse warning:
> > 
> > 	buttons = ~le16_to_cpup((__le16 *)(res + 8));
> > 
> 
> Below is what I woudl like to apply unless you see more issues with the
> patch. Andrew, if you could test it on your hardware to make sure it
> still works that woudl be great.
> 
> Thanks!
> 

Just to say I've tested this with jstest now and it seems to be in good
working order. There is a calibration issue on one axis, but I think
that's my hardware :-)

