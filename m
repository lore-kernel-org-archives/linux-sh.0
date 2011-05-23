From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 23 May 2011 05:45:22 +0000
Subject: Re: [PATCH 1/2] sh: remove warning and warning_symbol from struct stacktrace_ops
Message-Id: <20110523054522.GH5206@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1305205872-10321-1-git-send-email-richard@nod.at>
In-Reply-To: <1305205872-10321-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, ying.huang@intel.com, ssp@redhat.com, namhyung@gmail.com, fweisbec@gmail.com, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, robert.richter@amd.com

On Thu, May 12, 2011 at 03:11:11PM +0200, Richard Weinberger wrote:
> Both warning and warning_symbol are nowhere used.
> Let's get rid of them.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

The SH code obviously simply copied the x86 design, but it seems
reasonable to kill these off given that there are no users of the
interface. Applied, thanks.
