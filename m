From: Ian Campbell <Ian.Campbell@citrix.com>
Date: Wed, 24 Mar 2010 13:33:17 +0000
Subject: Re: [PATCH 01/10] irq: move some interrupt arch_* functions into
Message-Id: <1269437597.10129.67623.camel@zakaz.uk.xensource.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1269221770-9667-1-git-send-email-yinghai@kernel.org>
	<1269221770-9667-2-git-send-email-yinghai@kernel.org>
	<1269222962.3534.12.camel@concordia> <4BA6E4D1.6080704@kernel.org>
	<20100323071006.GJ13417@linux-sh.org>
In-Reply-To: <20100323071006.GJ13417@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: "lguest@ozlabs.org" <lguest@ozlabs.org>, "x86@kernel.org" <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2010-03-23 at 07:10 +0000, Paul Mundt wrote:

> The function pointer thing itself is also a bit unorthodox to say the
> least. You're introducing and passing around an opaque type just so you
> can get to a 'return 0' in the xen case as far as I can tell,

The ultimate aim is to have Xen use the chip data to store the event
channel information relating to each IRQ instead of keeping it in a
static NR_IRQs array, the new function only returns 0 as a placeholder
until this can be put in place (which depends on these changes), it
could as well have been left out for the time being (e.g. passing NULL
function pointer in the Xen case or whatever).

> so you
> could also just make arch_init_chip_data() a weak symbol and clobber it
> in the xen case, no?

A single kernel is able to boot native or Xen so a weak symbol doesn't
really work, having the function pointer at the arch level is one
similar option, I've replied to Thomas' similar suggestion.

Ian.

