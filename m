From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 03 May 2012 13:31:31 +0000
Subject: Re: [PATCH v3 02/10] ARM: sh-mobile: mackerel: Add error IRQ resource
Message-Id: <201205031531.31219.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <CABYn4szWZP4zZcz1MJ1xk5oCxiWh0nyJczcHGUqw4wE5MfJunA@mail.gmail.com>
 <1336039535.13013.17.camel@sauron.fi.intel.com>
In-Reply-To: <1336039535.13013.17.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dedekind1@gmail.com
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Brian Norris <computersforpeace@gmail.com>, Bastian Hecht <hechtb@googlemail.com>

On Thursday, May 03, 2012, Artem Bityutskiy wrote:
> On Thu, 2012-05-03 at 11:29 +0200, Bastian Hecht wrote:
> > 
> > Am 03.05.2012 08:01 schrieb "Artem Bityutskiy" <dedekind1@gmail.com>:
> > >
> > > On Thu, 2012-05-03 at 09:00 +0300, Artem Bityutskiy wrote:
> > > > On Wed, 2012-05-02 at 22:49 +0200, Rafael J. Wysocki wrote:
> > > > > On Wednesday, May 02, 2012, Bastian Hecht wrote:
> > > > > > Supply the platform data for the FLSTEI error IRQ.
> > > > > >
> > > > > > Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> > > > >
> > > > > I'm going to take this patch into the renesas.git tree and push
> > it
> > > > > upstream throuch arm-soc, if that's not a problem.
> > > >
> > > > It is already in the MTD tree with the rest of the 10 patches...
> > >
> > > Ops, sorry, this is not true. Then Bastian should separate it out
> > and
> > > not send it to the MTD tree.
> > 
> > Alright I'll do. I need to fix the compiler warnings of the mtd
> > patches anyway. So the board code is independant and can be pushed
> > already by Rafael, right? How is it supposed to work in general? I
> > think the sh-mobile list wants to be informed when I change something
> > in the flctl code. Would the right approach be to send 2 patchsets -
> > posted on both MLs so that Artem can take the mtd portions and Rafael
> > the mackerel ones?
> 
> If the patches are completely independent, post them separately.

Yes, please.

> I think it is also OK to CC more than one mailing list.

Yes, it is.

Thanks,
Rafael
