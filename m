From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Apr 2009 22:14:40 +0000
Subject: Re: [PATCH] fix mmap2 syscall
Message-Id: <20090420221440.GA31719@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4.2.0.58.J.20090421052216.0362b680@router.itonet.co.jp>
In-Reply-To: <4.2.0.58.J.20090421052216.0362b680@router.itonet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 21, 2009 at 06:48:43AM +0900, SUGIOKA Toshinobu wrote:
> Last argument of mmap2 system call is always (offset >> 12) in glibc
> regardless of the PAGE_SIZE, but do_mmap_pgoff function requires
> 'pgoff' parameter which is shifted by real PAGE_SHIFT.  So, we should
> adjust this argument if page size is not equal to 4k byte.
> 
Good catch, I added a sanity check and a comment. It will be in the
2.6.30 queue, thanks!
