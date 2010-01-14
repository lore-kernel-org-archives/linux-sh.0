From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Jan 2010 23:46:25 +0000
Subject: Re: [PATCH] cpuinfo_op: consolidate extern declaration
Message-Id: <20100114234625.GD25018@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201001141158.09795.hartleys@visionengravers.com>
In-Reply-To: <201001141158.09795.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, x86@kernel.org, mingo@redhat.com, tglx@linutronix.de, monstr@monstr.eu, hpa@zytor.com

On Thu, Jan 14, 2010 at 11:58:09AM -0700, H Hartley Sweeten wrote:
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
I guess we know from this list which architectures run sparse ;-)

Acked-by: Paul Mundt <lethal@linux-sh.org>
