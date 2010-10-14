From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Oct 2010 09:57:03 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
Message-Id: <20101014095703.GA17107@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 14, 2010 at 05:50:42PM +0900, Kuninori Morimoto wrote:
> If I use this patch on AP4,
> It said
> 
> ------------[ cut here ]------------
> WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/lib/kref.c:34 kref_get
> +0x20/0x3c()
> Modules linked in:
> [<c002802c>] (unwind_backtrace+0x0/0xe4) from [<c0031154>] (warn_slowpath_common
> +0x4c/0x64)
> [<c0031154>] (warn_slowpath_common+0x4c/0x64) from [<c0031184>] (warn_slowpath_n
> ull+0x18/0x1c)
> [<c0031184>] (warn_slowpath_null+0x18/0x1c) from [<c014a798>] (kref_get+0x20/0x3
> c)
> [<c014a798>] (kref_get+0x20/0x3c) from [<c01d9fec>] (clk_register+0xdc/0x190)
> [<c01d9fec>] (clk_register+0xdc/0x190) from [<c000b8dc>] (sh7372_clock_init+0x20
> /0xcc)
> [<c000b8dc>] (sh7372_clock_init+0x20/0xcc) from [<c000b9f8>] (ap4evb_timer_init+
> 0x8/0x30)
> [<c000b9f8>] (ap4evb_timer_init+0x8/0x30) from [<c0009d30>] (time_init+0x14/0x1c
> )
> [<c0009d30>] (time_init+0x14/0x1c) from [<c0008834>] (start_kernel+0x154/0x244)
> [<c0008834>] (start_kernel+0x154/0x244) from [<40008034>] (0x40008034)
> ---[ end trace 1b75b31a2719ed1c ]---
> 
Yes, I noticed after I sent it. You can fix this by changing it to:

	if (mapping->base)
		kref_get(..)

Or I can send you an updated path if you prefer.
