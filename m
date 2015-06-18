From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 18 Jun 2015 17:59:31 +0000
Subject: Re: [PATCH 2/2] Changes to existing files for 0PF FPGA board.
Message-Id: <20150618175931.GA11748@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434647946.861556@landley.net>
 <1434647946.861922@landley.net>
In-Reply-To: <1434647946.861922@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vivek Goyal <vgoyal@redhat.com>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Paul Bolle <pebolle@tiscali.nl>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Davidlohr Bueso <davidlohr@hp.com>, Richard Weinberger <richard@nod.at>, Zhigang Lu <zlu@tilera.com>, Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>, Max Filippov <jcmvbkbc@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, ysato@users.sourceforge.jp

On Thu, Jun 18, 2015 at 10:19:19AM -0700, Rob Landley wrote:
> Changes to existing files to add 0pf j2 board support.
> 

That's the second worse commit message and subject: line I've read
today.

And there's no signed off by line.

And there was no 1/2 patch sent.

And, most importantly:

> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig

I don't care about arch/sh/ stuff, why are you sending this to me?

You have a bit of work to do here...

greg k-h
