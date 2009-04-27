From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 27 Apr 2009 08:05:23 +0000
Subject: Re: [PATCH] SH-5: struct pt_regs:syscall_nr is unsigned.
Message-Id: <20090427080522.GB26020@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49F0C5BF.4090207@gmail.com>
In-Reply-To: <49F0C5BF.4090207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 23, 2009 at 09:47:11PM +0200, Roel Kluin wrote:
> vi arch/sh/include/asm/ptrace.h +9
> And note that struct pt_regs:syscall_nr is unsigned.
> 
> So I think something like the patch below is required, isn't it? As an
> alternative to the patch below, syscall_nr could become signed. what is
> preferred?
> --------------------------->8-------------8<------------------------------
> In restore_sigcontext() syscall_nr is set to -1, but it is unsigned for
> SH-5.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

syscall_nr should be signed, yes (the assembly code expects that as
well). I've switched it over now, good spotting!
