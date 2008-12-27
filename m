From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 27 Dec 2008 05:25:51 +0000
Subject: Re: Flag T-bit for syscall restart
Message-Id: <20081227052550.GA26369@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4.2.0.58.J.20081227113019.05455988@192.168.0.5>
In-Reply-To: <4.2.0.58.J.20081227113019.05455988@192.168.0.5>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 27, 2008 at 12:02:01PM +0900, SUGIOKA Toshinobu wrote:
> Hi,
> 
> Could someone explain me about the patch
> http://kerneltrap.org/mailarchive/git-commits-head/2008/10/20/3733624
> 
> I can't understand why T-bit(regs->sr & 1) is used
> as the condition about restarting syscall at the last hunk.
> 
Look at arch/sh/include/asm/syscall_32.h, it is used for syscall error
detection by the regset interface.
