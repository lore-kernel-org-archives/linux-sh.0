From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Jun 2009 17:48:31 +0000
Subject: Re: mmap address alignment when mmaping MAP_SHARED | MAP_FIXED
Message-Id: <20090615174831.GA30693@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <fd0635d10906150758w4f0c7d01q92d8e31546c976f1@mail.gmail.com>
In-Reply-To: <fd0635d10906150758w4f0c7d01q92d8e31546c976f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 15, 2009 at 11:58:47PM +0900, CHIKAMA Masaki wrote:
> Hello all.
> 
> On current sh kernel,  mmaped  address must be aligned 16KB boundary
> instead of getpagesize()
> when mmaping MAP_SHARED|MAP_FIXED. Can you removed this limitation ?
> 
> Please look at this.
>  http://sourceware.org/bugzilla/show_bug.cgi?id283
> 
The assertion that PAGE_SIZE is sufficient is utter nonsense. If the
dcache way size exceeds the page size then we have hard cache aliasing
constraints that shared mappings simply can not violate. SHMLBA has
exactly the same problem, and is likewise similarly defined on the
platforms that have to deal with these issues.

16kB is just an arbitrary size that avoids aliasing on all shared
mappings given the current cache architecture. However, it can of course
be compacted by calculating the shm alignment mask from the L1 dcache
shape information available through the ELF auxvt.

In any event, SH is not the only platform that has to deal with this, you
can grep the kernel for non-PAGE_SIZE SHMLBA definitions to see which
other architectures are similarly impacted. glibc has never dealt with
this effectively.
