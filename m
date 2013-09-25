From: Gleb Natapov <gleb@redhat.com>
Date: Wed, 25 Sep 2013 06:06:03 +0000
Subject: Re: [PATCH] KVM: ARM: enable Cortex A7 hosts
Message-Id: <20130925060603.GJ17294@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1379592108-28584-1-git-send-email-ulrich.hecht@gmail.com>
 <20130925053231.GC1916@verge.net.au>
In-Reply-To: <20130925053231.GC1916@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Ulrich Hecht <ulrich.hecht@gmail.com>, kvm@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

On Wed, Sep 25, 2013 at 02:32:31PM +0900, Simon Horman wrote:
> On Thu, Sep 19, 2013 at 02:01:48PM +0200, Ulrich Hecht wrote:
> > KVM runs fine on Cortex A7 cores, so they should be enabled. Tested on an
> > APE6EVM board (r8a73a4 SoC).
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> 
> Hi Ulrich,
> 
> I'm not entirely sure but it seems to me that you should expand the
> CC list of this patch someohow as it doesn't seem to have got any
> attention in the week since you sent it.
> 
Adding kvmarm@lists.cs.columbia.edu will be a good start.

> 
> # ./scripts/get_maintainer.pl -f arch/arm/kvm/guest.c
> Christoffer Dall <christoffer.dall@linaro.org> (supporter:KERNEL VIRTUAL MA...)
> Gleb Natapov <gleb@redhat.com> (supporter:KERNEL VIRTUAL MA...)
> Paolo Bonzini <pbonzini@redhat.com> (supporter:KERNEL VIRTUAL MA...)
> Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)
> kvmarm@lists.cs.columbia.edu (open list:KERNEL VIRTUAL MA...)
> kvm@vger.kernel.org (open list:KERNEL VIRTUAL MA...)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT)
> linux-kernel@vger.kernel.org (open list)
> 
> 
> 
> > ---
> >  arch/arm/kvm/guest.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> > index 152d036..05c62d5 100644
> > --- a/arch/arm/kvm/guest.c
> > +++ b/arch/arm/kvm/guest.c
> > @@ -192,6 +192,8 @@ int __attribute_const__ kvm_target_cpu(void)
> >  	switch (part_number) {
> >  	case ARM_CPU_PART_CORTEX_A15:
> >  		return KVM_ARM_TARGET_CORTEX_A15;
> > +	case ARM_CPU_PART_CORTEX_A7:
> > +		return KVM_ARM_TARGET_CORTEX_A15;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > -- 
> > 1.8.3.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
			Gleb.
