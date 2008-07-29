From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Jul 2008 10:30:15 +0000
Subject: Re: kernel (sometimes) boot
Message-Id: <20080729103015.GA320@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <488D864C.30808@spesonline.com>
In-Reply-To: <488D864C.30808@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 29, 2008 at 12:11:43PM +0200, Luca Santini wrote:
> Manuel Lauss wrote:
> >Going over the schematics again:
> >this is a 91c96: you should add a "smc91x-attrib" mem resource.  However I
> >don't know which address to set it to; please check the NIC's manual.
> >i.e.
> >
> >struct resource smc91x_res[] = {
> >	...
> >	[1] = {
> >		.name = "smc91x-attrib",
> >		.start = ???,
> >		.endd = ???,
> >		.flags = IORESOURCE_MEM,
> >	},
> >	...
> >};
> 
> i can't imagine where to find the addresses, i searched in edosk7760 and 
> smc91c96 manuals; others implementations that use this NIC ...
> someone knows? it's really necessary?
> 
It's going to be dependent on your board, so if it's not mentioned in
your board documentation, then you need to contact your board vendor
(obviously RTE in this case). On the other hand, you may also want to see
what the MPC Data folks have done for this platform. Whatever it maps
out to on other platforms is not going to be of any use to you.
