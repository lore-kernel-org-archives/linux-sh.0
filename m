From: Dale Larson <dlarson42@gmail.com>
Date: Tue, 15 Sep 2009 11:54:35 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <6e6aa1a80909150454q2ca83232n509f108b5c5859be@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 15, 2009 at 3:39 AM, Matt Fleming <matt@console-pimps.org> wrote:
> OK, these are unexpected fixups and similar to the issues I've been
> seeing. The current train of thought is that these unaligned accesses
> are a symptom of having aliases in the D-cache. I've been trawling
> through the cache/tlb code for SH4 and so far haven't found the bug.
>
> As a little experiment, could you try bumping the page size from 4K to
> 8K and see if the unaligned accesses go away? If they are caused by
> D-cache aliasing, in theory, they should disappear with 8K pages.

The 7763 only supports 1K, 4K, 64K and 1M pages. Would a 64K page
yield any useful info?

> Can you reliably reproduce this? A little tip when doing development is
> to turn on Verbose BUG() reporting, which is located in the Kernel
> Hacking menu. That'll give you a line and number in the source file.

I can certainly try. I see I forget to turn on BUG(). I'll post
results. Anything I can do to assist in finding this I'm open to.
Clearly I don't want to run my system without I/D Cache. :)

Thanks,
Dale Larson
Johnson Controls, Inc
