From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date: Thu, 15 Nov 2012 08:48:39 +0000
Subject: Re: [patch 4/4] mm, oom: remove statically defined arch functions of same name
Message-Id: <50A4AC67.5000102@jp.fujitsu.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.00.1211140111190.32125@chino.kir.corp.google.com> <alpine.DEB.2.00.1211140113480.32125@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1211140113480.32125@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

(2012/11/14 18:15), David Rientjes wrote:
> out_of_memory() is a globally defined function to call the oom killer.
> x86, sh, and powerpc all use a function of the same name within file
> scope in their respective fault.c unnecessarily.  Inline the functions
> into the pagefault handlers to clean the code up.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: David Rientjes <rientjes@google.com>

I think this is good.

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


