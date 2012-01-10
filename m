From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 10 Jan 2012 08:12:09 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: r8a7779 power domain support V2
Message-Id: <20120110081208.GC24305@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111222081204.12120.92511.sendpatchset@w520>
In-Reply-To: <20111222081204.12120.92511.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 10, 2012 at 03:50:01PM +0900, Magnus Damm wrote:
> Add power domain control support for the r8a7779 SoC V2.
> 
> This adds support for 4 power domains for I/O Devices
> together with code that can be used for CPU cores as well.
> 
> The only out of the ordinary experience is the need for
> ioremap() of SYSC registers. Because of that we need to
> execute some init function before setting up the domains.

Applied, thanks.

>  Built on top of linux-sh git rmobile/marzen branch.
> 
I've now merged rmobile/marzen in to rmobile-latest, so hopefully that
will be it for the merge window.
