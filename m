From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Feb 2008 02:54:53 +0000
Subject: Re: [PATCH] [SH] remove unneeded cast
Message-Id: <20080204025453.GA24901@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080202230347.a126a143.sfr@canb.auug.org.au>
In-Reply-To: <20080202230347.a126a143.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sat, Feb 02, 2008 at 11:03:47PM +1100, Stephen Rothwell wrote:
> now that platform_device_register_simple() takes a "const chat *".
> 
Presumably you mean 'const char *'. Also, in the future, please don't use
a subject purposely crafted to thwart git-am. Trivial patches are enough
of a nuisance without having to do things manually. I've applied it by
hand this time, grudgingly.
