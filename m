From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Sep 2009 12:36:16 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <20090915123615.GA23432@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 15, 2009 at 07:20:27AM -0500, Dale Larson wrote:
> >> The 7763 only supports 1K, 4K, 64K and 1M pages. Would a 64K page
> >> yield any useful info?
> > You can get 8kB pages by enabling extended mode TLB. But yes, 64k pages
> > are fine too, if using the compat mode TLB.
> 
> I can? I don't see it in the 7763 hardware manual. I only see this in
> the MMU section:
> 
> "This LSI has four instruction TLB (ITLB) entries and 64 unified TLB
> (UTLB) entries. UTLB
> copies are stored in the ITLB by hardware. A paging system is used for
> address translation, with
> four page sizes (1, 4, and 64 Kbytes, and 1 Mbyte) supported. It is
> possible to set the virtual
> address space access right and implement memory protection
> independently for privileged mode
> and user mode."
> 
I assumed SH7763 was an SH-X2 based core, but it turns out it is a
first-generation SH-4A, in which case it does not implement the extended
mode TLB. So the next available page size above 4k is 64k. I wasn't aware
there was anyone still running first generation SH-4A, I'll have to dust
some of mine off to see if I can reproduce your issues.

> If 64K would work with "compat mode TLB" how do I turn it on?

From the top menu, System Type -> Memory management options -> Kernel
page size. That will bring up a menu where you can cycle through the
available page sizes. I don't recommend 1MB for a system page size, as it
tends to interact badly with some of the slab allocators. 64k will give
you an idea of whether there are indeed any aliasing bugs lurking about.
