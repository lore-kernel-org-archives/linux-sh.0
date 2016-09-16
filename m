From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Fri, 16 Sep 2016 23:00:08 +0000
Subject: Re: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <20160916230008.GC2356@ZenIV.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20160916191218.GA12104@roeck-us.net>
 <20160916194532.GY2356@ZenIV.linux.org.uk>
 <20160916205938.GB29767@roeck-us.net>
 <20160916213141.GB2356@ZenIV.linux.org.uk>
 <20160916224704.GA21916@roeck-us.net>
In-Reply-To: <20160916224704.GA21916@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>

On Fri, Sep 16, 2016 at 03:47:04PM -0700, Guenter Roeck wrote:

> Adding pr_info() just before the "if (unlikely..." fixes the problem.
> 
> Commenting out the "if (unlikely())" code fixes the problem. 
> 
> Using a new variable "unsigned long x" for the return code instead of
> re-using __copy_size fixes the problem.
> 
> Replacing "return __copy_size;" with "return __copy_size & 0xffffffff;"
> fixes the problem.
> 
> The problem only seems to be seen if the copy size length is odd (more
> specifically, the failing copy always has a length of 25 bytes).
> 
> No idea what is going on. Bug in __copy_user() ? Compiler bug ?

Definitely a compiler bug.  __kernel_size_t is 32 bits on sh; that & 0xffffffff
should've been optimized away, for crying out loud!
