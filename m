From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 10:27:16 +0000
Subject: Re: [PATCH] sh: add some INTC_VECT for SH7757
Message-Id: <4BE3EB04.5000101@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DBEB.5060209@renesas.com>
In-Reply-To: <4BE3DBEB.5060209@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Fri, May 07, 2010 at 06:22:51PM +0900, Yoshihiro Shimoda wrote:
>> And I also add the setting of mv_nr_irqs because SH7757 has irqs
>> more than 256.
>>
> Since everything is using sparseirq these days, just bump up NR_IRQS to
> 512. CPUs should not be touching the machvec under any circumstances.
> 
May I change the NR_IRQS in arch/sh/include/asm/irq.h?
I thought that if this define is changed, all CPUs were affected.
Also I thought that there was not good to add "#ifdef CONFIG_CPU_SUBTYPE_SH7757" here.
What should I do?

Thanks,
Yoshihiro Shimoda
