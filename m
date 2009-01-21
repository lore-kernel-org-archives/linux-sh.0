From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 21 Jan 2009 10:37:08 +0000
Subject: Re: fix unaligned and nonexistent address handling
Message-Id: <20090121103708.GB17836@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4.2.0.58.J.20090121090500.00b5e5d0@router.itonet.co.jp>
In-Reply-To: <4.2.0.58.J.20090121090500.00b5e5d0@router.itonet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 21, 2009 at 09:42:10AM +0900, SUGIOKA Toshinobu wrote:
> unaligned and nonexistent address causes wrong exception
> handling in traps_32.c(handle_unaligned_access).
> 
> 'handle_unalinged_ins' should return -EFAULT if address error
> is fixed up with kernel exception table, otherwise 
> 'handle_unaligned_access' increases already fixed program counter
> and then crash.
> 
> for example
>    ioctl(fd, TCGETA, (struct termio *)-1)
> never return and stay in TASK_UNINTERRUPTIBLE state forever
> in my kernel.
> 
> Signed-off-by: SUGIOKA Toshinobu <sugioka@itonet.co.jp>
> 
Applied, thanks.
