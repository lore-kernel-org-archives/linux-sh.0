From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Thu, 24 Jan 2008 22:53:09 +0000
Subject: Re: [PATCH] sh: use declared coherent memory for dreamcast pci
Message-Id: <1201215189.6230.5.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Thu, 2008-01-24 at 22:33 +0000, Adrian McMenamin wrote:
> On Thu, 2008-01-24 at 18:40 +0900, Magnus Damm wrote:
> > sh: use declared coherent memory for dreamcast pci ethernet adapter
> > 
> > This patch makes the dreamcast use the recently added declared coherent
> > memory functions to point out the memory window suitable for dma.
> > 
> > Apart from cleaning up, this gives the dreamcast a proper memory allocator
> > for pci dma memory.
> > 
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> 
> 
> I get this now:
> 
> [    2.894858] IP-Config: Failed to open eth0
> [    2.898395] IP-Config: No network devices available.
> 
> So it appears, on first blush, that the patch breaks the driver. I'll
> test further to confirm.
> 

I can confirm that the patches:

f838a96ef5cdc261cb458b154e79b259688008b8
b82c3460d4a2d86cdac80e178a76f3833f1aecba
1b0a4750bf70d0e6f1b4ef573b1231530b9891be

all need to be reverted as they break the Dreamcast network driver

