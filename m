From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 02 Dec 2009 01:35:46 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <20091202013545.GA11047@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 30, 2009 at 05:02:54PM +0900, yoshii.takashi@renesas.com wrote:
> You can set boot parameters by config, ignoring data at the top of empty_zero_page.
> This and CONFIG_CMDLINE make zImage to be simple "load and go" capable binary,
> same as vmlinux (which has default boot parameters inside of it).
> 
> ---
> 
> I think people who already have "Linux aware" boot loader don't find anything interesting,
> but this was helpful when I was debugging with a monitor with serial file transfer only.
> IMHO, it might be a good to forget about parameters on the top of empty_zero_page.
> 
But this breaks the entire boot ABI, and probably only for the reason
that new bootloaders don't set up the argument page correctly. How about
just fixing the bootloaders to comply with the ABI rather than layering
more hacks in the kernel to make up for lazy bootloader developers?

While I don't have any objections to making the argument page optional in
itself, we still require some hints for things like whether we are using
32-bit boot mode and so on that need to be reflected somewhere. If you
wish to propose a new boot ABI and move away from overloading of the zero
page, that's fine with me, but we're not going to be breaking the ABI to
work around bootloader laziness.
