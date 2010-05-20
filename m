From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 May 2010 03:12:36 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: bump up NR_IRQS to 640
Message-Id: <20100520031236.GC6661@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311053352.26717.21158.sendpatchset@t400s>
In-Reply-To: <20100311053352.26717.21158.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 11, 2010 at 02:33:52PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Increase NR_IRQS to 640 on SH-Mobile ARM. With this
> applied the INTCS controller on sh7372 can be supported.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

I've dropped this one due to the INTCS_VECT_BASE shifting, feel free to
resubmit an updated version once support for 10-bit hardirqs hits
upstream.
