From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 11 Feb 2008 00:11:58 +0000
Subject: Re: How can I test a joystick type device?
Message-Id: <1202688718.6237.17.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202514806.6237.1.camel@localhost.localdomain>
In-Reply-To: <1202514806.6237.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Sun, 2008-02-10 at 19:43 +0000, Adrian McMenamin wrote:
> On Fri, 2008-02-08 at 19:18 -0600, Harley Laue wrote:
> > On Friday 08 February 2008 05:53:26 pm you wrote:
> > > As below shows I think I have successfully ported the 2.4 Dreamcast
> > > controller driver to 2.6 - but how can I test it? Is there a device I
> > > should be looking for in /dev that I could just cat?
> > Cool. 
> > if a /dev/input/js? or /dev/js? does not show up you can try:
> > mknod js0 c 13 0
> > then you can cat js0 and move the joystick to see if it's working
> 
> 
> Clearly the porting isn't as simple as I'd hoped: I cannot seem to get a
> udev rule to recognise the thing and if I create the node manually there
> is strangeness and an unwillingness to work!
> 
worked out what I was doing wrong...not compiling in the userland
support. Once that was done everything Just Worked ...afaics any way

