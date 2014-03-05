From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 05 Mar 2014 00:27:23 +0000
Subject: Re: [PATCH] irq-gic: remove file name from heading comment
Message-Id: <alpine.DEB.2.02.1403050112180.18573@ionos.tec.linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201312140224.53928.sergei.shtylyov@cogentembedded.com>
 <52D5CCFB.1090205@cogentembedded.com> <53166B67.2060804@cogentembedded.com>
In-Reply-To: <53166B67.2060804@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 5 Mar 2014, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/15/2014 02:49 AM, Sergei Shtylyov wrote:
> 
> > > File names in the heading comments  fell out of favor long ago, and this
> > > one
> > > weren't even changed when the driver was moved from arch/arm/common/, so
> > > remove
> > > it at last...
> 
> > > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> > > ---
> > > The patch is against the 'irq/core' branch of the 'tip.git' repo.
> 
> >     Thomas, is there a chance that you merge this patch for 3.14? Is it even
> > the right branch for cleanups (I'm seeing fixes there)?
> 
>    Thomas, will you ever reply to me? Who's maintaining the GIC driver, you?
> Or the patches shoud just go in via arm-soc.git?

That patch is so important^Wtrivial that it really can go via the
obvious trivial@kernel.org

Sigh....
