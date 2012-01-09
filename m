From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Jan 2012 01:23:52 +0000
Subject: Re: [PATCH 00/05] ARM: mach-shmobile: r8a7779 and Marzen V2
Message-Id: <20120109012351.GE25648@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111213163603.4096.10169.sendpatchset@w520>
In-Reply-To: <20111213163603.4096.10169.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 14, 2011 at 01:36:03AM +0900, Magnus Damm wrote:
> ARM: mach-shmobile: r8a7779 and Marzen V2
> 
> [PATCH 01/05] ARM: mach-shmobile: r8a7779 and Marzen base support V2
> [PATCH 02/05] ARM: mach-shmobile: r8a7779 PFC GPIO-only support V2
> [PATCH 03/05] ARM: mach-shmobile: r8a7779 PFC function support
> [PATCH 04/05] ARM: mach-shmobile: Marzen SCIF2/SCIF4 support
> [PATCH 05/05] ARM: mach-shmobile: Marzen LAN89218 support
> 
These are now in rmobile/marzen which was branched off of rmobile-latest
with the pfc and cpg topic branches merged in.

It will need to be updated both with a defconfig and updating for the
serial changes, but these can be layered on incrementally.
