From: Matt Fleming <matt@console-pimps.org>
Date: Wed, 15 Sep 2010 06:19:52 +0000
Subject: Re: IRQ flags patch
Message-Id: <20100915061952.GB26815@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6218.1284051389@redhat.com>
In-Reply-To: <6218.1284051389@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 13, 2010 at 11:48:26PM +0100, David Howells wrote:
> Matt Fleming <matt@console-pimps.org> wrote:
> 
> > I'm guessing the underscores should be dropped from
> > __arch_local_irq_save() in arch/sh/kernel/irq_32.c seeing as there are
> > no callers of that function anywhere?
> > 
> > However, this patch series fails to run on my 7785lcr board. You also
> > need to move RAW_IRQ_DISABLED and RAW_IRQ_ENABLED in
> > arch/sh/include/asm/irqflags.h to ARCH_IRQ_DISABLED and
> > ARCH_IRQ_ENABLED. The attached diff gets my board booting.
> 
> Seems likely, thanks.  I've merged your patch into my GIT tree and rebased.
> 
> http://git.kernel.org/?p=linux/kernel/git/dhowells/linux-2.6-irqflags.git;a=summary
> 
> If you could check that, that'd be great!

This looks good to me and it boots fine. Thanks!

Acked-by: Matt Fleming <matt@console-pimps.org>
