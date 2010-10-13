From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Oct 2010 09:49:07 +0000
Subject: Re: [PATCH] ARM: shmobile: break out sh7372 platform devices
Message-Id: <20101013094907.GC10013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101013072211.19725.56630.sendpatchset@t400s>
In-Reply-To: <20101013072211.19725.56630.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 13, 2010 at 04:22:11PM +0900, Magnus Damm wrote:
> This patch introduces sh7372_late_devices which
> should include all regular processor specific
> platform devices.
> 
> Early platform devices for console and timers
> should be put on the sh7372_early_devices list,
> all other devices should be on sh7372_late_devices.

On Wed, Oct 13, 2010 at 04:29:31PM +0900, Magnus Damm wrote:
> Move SH-Mobile ARM systems over from the legacy
> "clk" member of struct sh_timer_config to using
> the device name and clkdev for clock matching.

On Wed, Oct 13, 2010 at 04:39:18PM +0900, Magnus Damm wrote:
> Just use MMCIF as name to match the sh7372 data sheet.

These are all applied to the genesis tree now, thanks.
