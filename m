From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 27 May 2012 13:00:56 +0000
Subject: Re: [PATCH] sh: fix sh7724 compilation
Message-Id: <20120527130055.GB29888@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1205251620540.13353@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1205251620540.13353@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 25, 2012 at 04:24:53PM +0200, Guennadi Liakhovetski wrote:
> Fix compile breakage:
> 
> arch/sh/kernel/process.c: In function 'arch_dup_task_struct':
> arch/sh/kernel/process.c:23: error: implicit declaration of function 'unlazy_fpu'
> 
> Presumably, other 32-bit FPU-enabled SuperH SoCs are affected too.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Already fixed.
