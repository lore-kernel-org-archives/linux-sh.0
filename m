From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Feb 2008 01:12:25 +0000
Subject: Re: Various section mismatches
Message-Id: <20080204011225.GB22021@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1202080862.9936.4.camel@localhost.localdomain>
In-Reply-To: <1202080862.9936.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 03, 2008 at 11:21:02PM +0000, Adrian McMenamin wrote:
>   LD      arch/sh/kernel/cpu/built-in.o
> WARNING: arch/sh/kernel/cpu/built-in.o(.cpuinit.text+0x164): Section mismatch in reference from the function sh_cpu_init() to the function .init.text:detect_cpu_and_cache_system()
> The function __cpuinit sh_cpu_init() references
> a function __init detect_cpu_and_cache_system().
> If sh_cpu_init is only used by detect_cpu_and_cache_system then
> annotate sh_cpu_init with a matching annotation.
> 
Something seems to be wrong with your mailer, as a patch was strangely
missing.
