From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 21 Mar 2008 03:39:02 +0000
Subject: Re: [PATCH] Use relative path when creating include/asm/{mach,cpu} symlinks
Message-Id: <20080321033902.GA16295@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <47DEC594.6010502@gmail.com>
In-Reply-To: <47DEC594.6010502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 18, 2008 at 08:04:06PM +0100, Franck Bui-Huu wrote:
> Franck Bui-Huu wrote:
> > Well it should be pretty trivial to make this patch works both cases
> > although it can't be called a "clean up" patch.
> > 
> 
> and here's an updated patch, which should work for both cases.
> 
> It's pretty simple and not very intrusive so it could be a temporary fix
> until the massive header reorganization happen.
> 
Looks fine, and it works fine with both cases. I've applied it, thanks.
