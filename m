From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 29 Jan 2009 06:39:29 +0000
Subject: Re: [PATCH] SH: fix start_thread and user_stack_pointer macros
Message-Id: <20090129063929.GF32243@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49788DBE.5010802@gmail.com>
In-Reply-To: <49788DBE.5010802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 22, 2009 at 04:16:14PM +0100, Roel Kluin wrote:
> Fix macros start_thread and user_stack_pointer.
> When these macros aren't called with a variable named regs as second
> argument, this will result in a build failure.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Applied, thanks.
