From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 03 Mar 2008 09:00:07 +0000
Subject: Re: sh r7780mp_defconfig compile error
Message-Id: <20080303090007.GA10165@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080302213506.GD25484@cs181133002.pp.htv.fi>
In-Reply-To: <20080302213506.GD25484@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 03, 2008 at 05:53:50PM +0900, Jeongdo Son wrote:
> I had the same compile error.
> I traced the source and noticed that P#SEGADDR are only defined when
> CONFIG_PMB is NOT selected.
> If your system is not using physical 32-bit addressing function by
> SH-4A PMB, setting off the CONFIG_PMB can be a solution.
> I think some dummy macros should be added to avoid this compile error.
> 
There are a few other things that are broken with CONFIG_PMB on R7780MP,
so stubbing around it for the time being doesn't help anything but the
current config build. The defconfig should just be updated to disable it
for this release cycle.
