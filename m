From: Paul Mundt <paul.mundt@renesas.com>
Date: Mon, 24 Nov 2008 03:37:53 +0000
Subject: Re: git pull breaks edosk7760 kernel
Message-Id: <20081124033753.GD22035@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4927F204.5090805@spesonline.com>
In-Reply-To: <4927F204.5090805@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Nov 23, 2008 at 04:06:18PM +0100, Luca Santini wrote:
> Thanks Matt,
> i tried to use git-bisect, and i hope i used it fine; this is my final 
> output:
>
>
>
>
> 406f9e9cfe5d44fbcdc6e8f4b1f205e1160c0fef is first bad commit
> commit 406f9e9cfe5d44fbcdc6e8f4b1f205e1160c0fef
> Author: Paul Mundt <lethal@linux-sh.org>
> Date:   Tue Nov 18 14:22:39 2008 +0900
>
>    sh: __udivdi3 -> do_div() in softfloat lib.
>       Inhibit the generation of __udivdi3 for the softfloat lib, use 
> do_div()
>    outright.
>       Signed-off-by: Paul Mundt <lethal@linux-sh.org>
>
> :040000 040000 70142433e2ab902b50182ea127ea1e56803dac87 
> 7801a0a6ef1e2d6703f82fa82587ba03fe140048 M	arch
>
>
>
>
> ...and now?
>
Reverting this fixes your kernel? I'll take another look at it and see if
I broke something accidentally. Note that now there are also __udivdi3
implementations in the kernel, so I wonder if your compiler is clashing
with those.
