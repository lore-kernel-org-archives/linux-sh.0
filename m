From: Simon Horman <horms@verge.net.au>
Date: Fri, 17 Jul 2015 04:04:57 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: r8a7779 Marzen legacy removal
Message-Id: <20150717040453.GA21932@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150716075342.1198.63257.sendpatchset@little-apple>
In-Reply-To: <20150716075342.1198.63257.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 16, 2015 at 04:53:42PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7779 Marzen legacy removal
> 
> [PATCH 01/03] ARM: shmobile: marzen: Remove legacy board code
> [PATCH 02/03] ARM: shmobile: r8a7779: Remove legacy SoC code
> [PATCH 03/03] ARM: shmobile: Remove marzen_defconfig
> 
> This series removes the r8a7779 Marzen legacy code. Board
> code for Marzen written in C and r8a7779 SoC code including
> old clock framework code and platform devices are removed.
> 
> Existing Marzen users need to move over to Multiplatform and
> shmobile_defconfig. The DT file r8a7779-marzen.dts file is
> the same as for the legacy case.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I have queued these up.

FYI doing so was rather awkward as patch 01 and especially patch 02
have various conflicts with patches in several different branches.

For now I have gone with queuing them up on top of the marzen-reference
removal patches, which leaves minor conflicts mainly in Kconfig and
Makefiles. There is also a conflict with the marzen board code fix you
recently posted which is present in a separate fixes branch. I wonder if it
would make sense to drop that patch now removal of the code it fixes is
queued up.
