From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 10 Mar 2009 03:52:31 +0000
Subject: Re: [PATCH] sh: hibernation support V2
Message-Id: <20090310035230.GA9430@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306094702.8715.75694.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306094702.8715.75694.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2009 at 06:47:02PM +0900, Magnus Damm wrote:
> Add Suspend-to-disk / swsusp / CONFIG_HIBERNATION support
> to the SuperH architecture V2.
> 
> To suspend, use "swapon /dev/sda2; echo disk > /sys/power/state"
> To resume, pass "resume=/dev/sda2" on the kernel command line.
> 
> The patch "pm: rework includes, remove arch ifdefs V2" is
> needed to allow the generic swsusp code to build properly.
> 
> Hibernation is not enabled with this patch though, a patch
> setting ARCH_HIBERNATION_POSSIBLE will be submitted later.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  V2 contains changes according to feedback from Paul.
> 
This is a good start anyways, applied.
