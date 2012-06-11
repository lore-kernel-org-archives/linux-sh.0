From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Jun 2012 03:55:43 +0000
Subject: Re: [PATCH 00/08] mach-shmobile: Emma Mobile EV2 support V3
Message-Id: <20120611035543.GD10170@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120516064449.32286.77941.sendpatchset@w520>
In-Reply-To: <20120516064449.32286.77941.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, May 16, 2012 at 03:44:49PM +0900, Magnus Damm wrote:
> mach-shmobile: Emma Mobile EV2 support V3
> 
> [PATCH 01/08] mach-shmobile: Emma Mobile EV2 SoC base support V3
> [PATCH 02/08] ARM: Undelete KZM9D mach-type V3
> [PATCH 03/08] mach-shmobile: KZM9D board support V3
> [PATCH 04/08] mach-shmobile: Emma Mobile EV2 SMP support V3
> [PATCH 05/08] mach-shmobile: Emma Mobile EV2 GPIO support V3
> [PATCH 06/08] mach-shmobile: KZM9D board Ethernet support V3
> [PATCH 07/08] mach-shmobile: Emma Mobile EV2 DT support V3
> [PATCH 08/08] mach-shmobile: Use DT_MACHINE for KZM9D V3
> 
Now that this series has hit mainline I notice that no defconfig is
available for the board, so there's no way to have any coverage in it in
-next. When we're at a point where multiple boards are enabled in one
config then they can be consolidated, but it's not acceptable to have a
platform upstream that people have no way of building.
