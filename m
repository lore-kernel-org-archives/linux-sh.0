From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Sep 2009 11:57:18 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <20090915115717.GA22736@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 15, 2009 at 06:54:35AM -0500, Dale Larson wrote:
> On Tue, Sep 15, 2009 at 3:39 AM, Matt Fleming <matt@console-pimps.org> wrote:
> > OK, these are unexpected fixups and similar to the issues I've been
> > seeing. The current train of thought is that these unaligned accesses
> > are a symptom of having aliases in the D-cache. I've been trawling
> > through the cache/tlb code for SH4 and so far haven't found the bug.
> >
> > As a little experiment, could you try bumping the page size from 4K to
> > 8K and see if the unaligned accesses go away? If they are caused by
> > D-cache aliasing, in theory, they should disappear with 8K pages.
> 
> The 7763 only supports 1K, 4K, 64K and 1M pages. Would a 64K page
> yield any useful info?
> 
You can get 8kB pages by enabling extended mode TLB. But yes, 64k pages
are fine too, if using the compat mode TLB.
