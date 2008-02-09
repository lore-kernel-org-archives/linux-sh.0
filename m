From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 09 Feb 2008 14:57:29 +0000
Subject: Re: How can I test a joystick type device?
Message-Id: <1202569049.6282.3.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202514806.6237.1.camel@localhost.localdomain>
In-Reply-To: <1202514806.6237.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Sat, 2008-02-09 at 11:58 +0900, Paul Mundt wrote:
> On Fri, Feb 08, 2008 at 11:53:26PM +0000, Adrian McMenamin wrote:
> > As below shows I think I have successfully ported the 2.4 Dreamcast
> > controller driver to 2.6 - but how can I test it? Is there a device I
> > should be looking for in /dev that I could just cat?
> > 
> Other than the existing suggestion, you can also use evdev for just
> cat'ing and getting the raw events.
> -

I need to get udev to recognise the driver as a joystick and then create
a node for it. Not sure how to do that...

