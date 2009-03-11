From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Mar 2009 08:31:45 +0000
Subject: Re: [PATCH 00/09] sh: clean up pci code
Message-Id: <20090311083145.GG6281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080219123420.4266.2965.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080219123420.4266.2965.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 19, 2008 at 09:34:20PM +0900, Magnus Damm wrote:
> These patches rework the pci code for the sh architecture.
> 
> Currently each board implements some kind of ioport to address mapping. Some
> boards use generic_io_base others try passing addresses as io ports. This is
> the first set of patches that try to unify the pci code as much as possible
> to avoid duplicated code. This will in the end lead to fewer lines board
> specific code and more generic code.
> 
> Only high level stuff so far. These patches avoid changing low level bits,
> I have patches for sh7751 and sh7780 doing that already. I'll post then 
> later on this week after some more testing.
> 
> Have fun and people with pci host controllers - please test!
> 
I've merged this series in to the sh/pci-rework topic branch. It needs
some more work, some of which I've already done, but it makes more sense
to concentrate development in one place and merge it when it's ready.
