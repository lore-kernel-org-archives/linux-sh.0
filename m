From: Christoffer Dall <christoffer.dall@linaro.org>
Date: Thu, 26 Sep 2013 14:41:41 +0000
Subject: Re: [PATCH resend] KVM: ARM: enable Cortex A7 hosts
Message-Id: <20130926144041.GA1389@cbox>
List-Id: <linux-sh.vger.kernel.org>
References: <1380196131-23326-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1380196131-23326-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht@gmail.com>
Cc: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, gleb@redhat.com, horms@verge.net.au

On Thu, Sep 26, 2013 at 01:48:51PM +0200, Ulrich Hecht wrote:
> KVM runs fine on Cortex A7 cores, so they should be enabled. Tested on an
> APE6EVM board (r8a73a4 SoC).
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> ---
>  arch/arm/kvm/guest.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> index 152d036..05c62d5 100644
> --- a/arch/arm/kvm/guest.c
> +++ b/arch/arm/kvm/guest.c
> @@ -192,6 +192,8 @@ int __attribute_const__ kvm_target_cpu(void)
>  	switch (part_number) {
>  	case ARM_CPU_PART_CORTEX_A15:
>  		return KVM_ARM_TARGET_CORTEX_A15;
> +	case ARM_CPU_PART_CORTEX_A7:
> +		return KVM_ARM_TARGET_CORTEX_A15;
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 1.8.3.1
>

nack

we need to have support and implementation for A7 cores and not try to
shoehorn A7 support by pretending that it's an A15.

The fact that you have tested this and it happens to work with the
workload you ran does not mean it is the right solution.  At the very
least, you need to document and think about the different system
register implementation and deal with them correctly.

-Christoffer
