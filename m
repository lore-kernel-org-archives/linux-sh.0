From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Jan 2016 01:55:03 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva dts: Correct extal1 frequency to 24 MHz
Message-Id: <20160118015502.GG1905@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450435896-6026-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdUZx5ynmJOz+EDzFSGOgVQraVquj0GtdMgkE0UxCQ-V2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUZx5ynmJOz+EDzFSGOgVQraVquj0GtdMgkE0UxCQ-V2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jan 05, 2016 at 02:37:07PM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 18, 2015 at 11:51 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > On r8a7740/armadillo, actual clock rates are ca. 4% lower than reported
> > by /sys/kernel/debug/clk/clk_summary. Correct the extal1 frequency from
> > 25 MHz to 24 MHz to fix this.
> >
> > This matches the Armadillo-800 EVA Product Manual, which claims the main
> > crystal runs at 24 MHz, and the old legacy/reference board code.
> 
> Ping? I think we want this applied to -stable and -ltsi, too.

Sorry for letting this slip through the cracks.

I have queued up the following as a fix for v4.5.

From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: dts: armadillo800eva Correct extal1 frequency to 24 MHz

On r8a7740/armadillo, actual clock rates are ca. 4% lower than reported
by /sys/kernel/debug/clk/clk_summary. Correct the extal1 frequency from
25 MHz to 24 MHz to fix this.

This matches the Armadillo-800 EVA Product Manual, which claims the main
crystal runs at 24 MHz, and the old legacy/reference board code.

Fixes: 25aa7ba3fdfb ("ARM: shmobile: armadillo800eva: Sync DTS")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 105d9c95de4a..5c76dcc89df5 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -180,7 +180,7 @@
 };
 
 &extal1_clk {
-	clock-frequency = <25000000>;
+	clock-frequency = <24000000>;
 };
 &extal2_clk {
 	clock-frequency = <48000000>;
-- 
2.1.4

