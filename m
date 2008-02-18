From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 18 Feb 2008 20:11:20 +0000
Subject: Re: Current git very broken on the Dreamcast
Message-Id: <1203365480.6637.2.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1203187080.6737.3.camel@localhost.localdomain>
	 <1203191304.6737.5.camel@localhost.localdomain>
	 <aec7e5c30802180057k76050c02wfe3790cf379f7d5f@mail.gmail.com>
In-Reply-To: <aec7e5c30802180057k76050c02wfe3790cf379f7d5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, Paul Mundt <lethal@users.sourceforge.net>, matsu@igel.co.jp, LKML <linux-kernel@vger.kernel.org>


On Mon, 2008-02-18 at 17:57 +0900, Magnus Damm wrote:
> Hi Adrian,
> 
> [fixed up Matsubara-sans address]
> 
> On Feb 17, 2008 4:48 AM, Adrian McMenamin
> <adrian@newgolddream.dyndns.info> wrote:
> > On Sat, 2008-02-16 at 18:38 +0000, Adrian McMenamin wrote:
> > > Will seek to bisect this, but I have just updated my sources to the
> > > latest git and it is not booting at all on the Dreamcast.
> > >
> > > With early printk on, I get nothing more than this before an instant
> > > reboot:
> > >
> > > [    0.000000] Linux version 2.6.25-rc2-10953-g52065cd
> > > (adrian@bossclass) (gcc version 3.4.6) #511 PREEMPT Sat Feb 16 18:31:43
> > > GMT 2008
> > > [    0.000000] console [sercon0] enabled
> > > [    0.000000] Booting machvec: Sega Dreamcast
> >
> >
> > adrian@bossclass:~/gdrom-dev$ git bisect good
> > e036eaa681a17f71b64f6d9040fe605555623919 is first bad commit
> > commit e036eaa681a17f71b64f6d9040fe605555623919
> > Author: Magnus Damm <magnus.damm@gmail.com>
> > Date:   Thu Feb 14 13:52:43 2008 +0900
> >
> >     sh: use ctrl_in/out for on chip pci access
> >
> >     This patch makes sure ctrl_inN/outN are used instead of inN/outN for
> > on chip
> >     pci registers. Without this patch addresses may be adjusted using
> > the value
> >     in generic_io_base. This patch makes it possible to set
> > generic_io_base and
> >     have pci without reading and writing all over the place.
> >
> >     Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >     Acked-by: Katsuya MATSUBARA <matsu@igel.co.jp>
> >     Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> >
> > :040000 040000 17a9f8181301e3a082d8a1a2fdef9b13ff1185e4
> > 87e4a2e912be56b0d12e8a92db9489d6615c31f7 M      arch
> 
> Thanks for tracking this down and sorry for breaking the dreamcast pci driver.
> 
> Most code for the dreamcast currently do direct register access using
> ctrl_inN/outN or readN/writeN. Only a few places use inN/outN and
> depend on the value of generic_io_base. Doing inN/outN is ok (but
> outdated, use ioreadN/iowriteN instead) in a portable pci/isa driver,
> but it doesn't make sense for any dreamcast specific code to rely on
> generic_io_base. For the dreamcast we already know the address at
> compile time so doing adjustment during runtime is just unnecessary
> overhead.
> 
> It is of course possible to revert the dreamcast-specific bits of the
> commit you pointed out, but I think the change for the dreamcast makes
> sense since it makes the code both faster and more uniform.
> 
> However, at this point it is broken. Sorry about that. I just looked
> through all upstream dreamcast-specific code I could find and irq.c is
> now the only file that does inN/outN. I've attached a patch that makes
> the irq code independent of generic_io_base. There is also another
> patch attached that adjusts the addresses of the pci register.
> Together they should solve the problem you are seeing. Please try them
> on top of 2.6.25-rc2.
> 
> With these patches io ports count from 0 -> 8k-1 instead of being a
> pointer. We currently rely on generic_io_base logic but that will be
> changed in the future.
> 
Magnus,

This fixed the original problem but re-introduced the problem I had
before with not having a a working nic - so it's stole broken atm:

[    2.220263] NET: Registered protocol family 17
[    2.224976] RPC: Registered udp transport module.
[    2.228064] RPC: Registered tcp transport module.
[    2.740995] IP-Config: Failed to open eth0
[    2.744076] IP-Config: No network devices available.
[    2.748232] Looking up port of RPC 100003/2 on 192.168.61.50


