From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 20 Jan 2009 03:22:58 +0000
Subject: Re: ERESTART* seen by userland
Message-Id: <20090120032258.GD12965@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
In-Reply-To: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jan 17, 2009 at 08:40:15AM +0900, Kaz Kojima wrote:
> Hi,
> 
> It seems that some syscalls return with ERESTART* errno when
> they should return EINTR in the recent SH kernels.
> Has anybody experienced this?
> 
I haven't hit this personally, but the only logical explanation I can
think of for this is the T-bit setting in the syscall restart code. I
suppose I will have to find another bit to use. Can you confirm if
getting rid of regs->sr T-bit manipulation makes this go away?
