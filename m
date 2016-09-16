From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Fri, 16 Sep 2016 21:20:07 +0000
Subject: Re: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <20160916212007.GA2356@ZenIV.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20160916191218.GA12104@roeck-us.net>
 <20160916200320.GZ2356@ZenIV.linux.org.uk>
 <20160916203205.GA29660@roeck-us.net>
In-Reply-To: <20160916203205.GA29660@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>

On Fri, Sep 16, 2016 at 01:32:05PM -0700, Guenter Roeck wrote:
> > BTW, could you post your .config and information about your userland?  E.g.
> > is that ip(8) a busybox one, etc.  If it's busybox, this smells like EINVAL
> > and EFAULT resp. coming from recvmsg() on netlink sockets, with nothing
> > extraordinary in iovecs, AFAICS...
> 
> Please see https://github.com/groeck/linux-build-test/tree/master/rootfs/sh.
> The rootfs is some three years old. I don't remember how I created it :-).

Will do.  In the meanwhile, could you verify that reverting that commit
really fixes the problem (and, if possible, check if the mainline has
the same problem)?

This is really very strange - I don't see anything in that commit to
alter the return value or to stomp on anything that shouldn't be modified,
error or no error.  The rules from copy_from_user(to, from, n) are
	* if everything in n-bytes range starting at from is readable userland
memory, its contents should be copied into n-bytes range starting at to and
0 should be returned.
	* otherwise a poitive number between 1 and n should be returned;
if it returns n - m, everything in m-bytes range starting at from should be
readable userland memory and its contents should be copied into m-bytes
range starting at to, with remaining n - m bytes of n-bytes range starting
at to getting zeroed.  That includes the case of m equal to 0 (i.e. return
value being equal to n) - then nothing is copied and the entire n-bytes
range starting at to is zeroed.
