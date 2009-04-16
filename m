From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Apr 2009 06:10:12 +0000
Subject: Re: [PATCH 00/05] Remaining earlytimer / Early Platform patches
Message-Id: <20090416061011.GD26667@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090415104956.29940.86548.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090415104956.29940.86548.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 15, 2009 at 07:49:56PM +0900, Magnus Damm wrote:
> Remaining earlytimer / Early Platform patches:
> 
> [PATCH 01/05] clocksource: sh_cmt earlytimer support
> [PATCH 02/05] sh: arch earlytimer support
> [PATCH 03/05] sh: Add plat_early_device_setup()
> [PATCH 04/05] sh: Early Platform Data for SuperH Mobile
> [PATCH 05/05] sh: Let SH_TIMER_CMT select GENERIC_TIME
> 
> This patchset contains all the outstanding earlytimer-specific patches
> for the SuperH architecture. earlytimer is implemented using sh_cmt as
> Early Platform Driver together with Early Platform Data for SuperH Mobile.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Ok, 1-4 are applied to the `sh/earlytimer' topic branch. (I just fixed up
the time_32.c bits by hand). Once the early platform stuff hits upstream,
I'll fold this in to the 2.6.31 queue.

You can work on top of this branch for reworking the rest of the
sys_timer bits for the next merge window in the meantime, though you'll
still have to manually apply 05/05 as I have no desire to break bisect on
sh2a :-)
