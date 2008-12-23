From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Tue, 23 Dec 2008 01:07:35 +0000
Subject: Re: [PATCH] sh: maple: add support for Maple controller as a
Message-Id: <1229994455.22856.61.camel@brick>
List-Id: <linux-sh.vger.kernel.org>
References: <1229728542.1441.6.camel@localhost.localdomain>
	 <20081222150636.8dc20d61.akpm@linux-foundation.org>
In-Reply-To: <20081222150636.8dc20d61.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org, lethal@linux-sh.org

On Mon, 2008-12-22 at 15:06 -0800, Andrew Morton wrote:
> On Fri, 19 Dec 2008 23:15:42 +0000
> Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:
> 
> > Not sure what happened with earlier submissions, so here is an up-to-date
> > patch for the Dreamcast Maple controlled.
> > 
> > 
> > Add support for the SEGA Dreamcast Maple controller as a joystick
> > 
> > ...
> >
> > +static void dc_pad_callback(struct mapleq *mq)
> > +{
> > +	unsigned short buttons;
> > +	struct maple_device *mapledev = mq->dev;
> > +	struct dc_pad *pad = maple_get_drvdata(mapledev);
> > +	struct input_dev *dev = pad->dev;
> > +	unsigned char *res = mq->recvbuf;
> > +
> > +	buttons = ~cpu_to_le16(*(unsigned short *)(res + 8));
> 
> hm, could that be simplified?

And as a bonus fix the obvious sparse warning:

	buttons = ~le16_to_cpup((__le16 *)(res + 8));

Cheers,

Harvey

