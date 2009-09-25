From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 25 Sep 2009 01:58:09 +0000
Subject: Re: [PATCH] SH: includecheck fix: dwarf.c
Message-Id: <20090925015809.GB12099@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1253627426.3784.24.camel@ht.satnam>
In-Reply-To: <1253627426.3784.24.camel@ht.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Matt Fleming <matt@console-pimps.org>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Sep 22, 2009 at 07:20:26PM +0530, Jaswinder Singh Rajput wrote:
> 
> fix the following 'make includecheck' warning:
> 
>   arch/sh/kernel/dwarf.c: asm/dwarf.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>

Applied, thanks.
