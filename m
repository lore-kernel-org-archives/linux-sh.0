From: Michal Simek <monstr@monstr.eu>
Date: Fri, 15 Jan 2010 08:06:16 +0000
Subject: Re: [PATCH] cpuinfo_op: consolidate extern declaration
Message-Id: <4B5021F8.4010703@monstr.eu>
List-Id: <linux-sh.vger.kernel.org>
References: <201001141158.09795.hartleys@visionengravers.com>
In-Reply-To: <201001141158.09795.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, x86@kernel.org, mingo@redhat.com, tglx@linutronix.de, lethal@linux-sh.org, hpa@zytor.com

H Hartley Sweeten wrote:
> cpuinfo_op: consolidate extern declaration
> 
> All the architectures supported by the kernel also support
> /proc/cpuinfo. Only a couple actually declare the seq_operations
> as extern. All the others will produce a sparse warning like:
> 
> warning: symbol 'cpuinfo_op' was not declared. Should it be static?
> 
> Fix all the warnings and consolidate the declaration by putting it
> in <linux/seq_file.h>.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> 

Tested-by: Michal Simek <monstr@monstr.eu>


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
