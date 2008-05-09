From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 May 2008 05:20:49 +0000
Subject: Re: [PATCH 1/1] mm: define default cpu_to_node
Message-Id: <20080509052049.GA2161@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080508230238.468043000@polaris-admin.engr.sgi.com> <20080508230238.649815000@polaris-admin.engr.sgi.com>
In-Reply-To: <20080508230238.649815000@polaris-admin.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Travis <travis@sgi.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, "David S. Miller" <davem@davemloft.net>, "William L. Irwin" <wli@holomorphy.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, May 08, 2008 at 04:02:39PM -0700, Mike Travis wrote:
>   * Some architectures have CONFIG_NUMA=y but do not define a
>     default cpu_to_node macro.  This provides the default in
>     asm-generic/topology.h but it relies on the fact that
>     cpu_to_node is a defined macro (and not an inline function).
> 
NACK.. This isn't going to work anyways, cpu_to_node() is just where the
first build error occurs. If you do this, then parent_node() is the next
one to blow up, node_to_cpumask() after that, etc, etc. For now I've just
stubbed the asm-generic/topology.h definitions in to asm-sh/topology.h.
