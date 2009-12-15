From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Dec 2009 03:37:58 +0000
Subject: Re: [PATCH] sh: Fix up FPU build for SH5
Message-Id: <20091215033758.GC7395@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1260821524-32579-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1260821524-32579-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 14, 2009 at 08:12:04PM +0000, Matt Fleming wrote:
> After the recent FPU optimisation commit the signature of save_fpu()
> changed. "regs" wasn't used in the implementation of save_fpu() anyway.

Applied, thanks.
