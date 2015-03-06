From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Mar 2015 11:31:28 +0000
Subject: Re: [PATCH 01/16] ARM: shmobile: r8a7778: synchronize dts with reference platform
Message-Id: <20150306113128.GC27105@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
 <8c4892a633f08edbc54b6b59a673f76bd1cd7e94.1425518337.git.horms+renesas@verge.net.au>
 <54F85467.2010700@cogentembedded.com>
In-Reply-To: <54F85467.2010700@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 05, 2015 at 04:04:39PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 3/5/2015 4:58 AM, Simon Horman wrote:
> 
> >From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> >This moves everything to the legacy dts that is missing there to make it
> >suitable for use with multiplatform.
> 
> >Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/boot/dts/r8a7778-bockw.dts | 106 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> 
> >diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
> >index 46a884d..7347223 100644
> >--- a/arch/arm/boot/dts/r8a7778-bockw.dts
> >+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> >@@ -16,17 +16,123 @@
> [...]
> >+
> >+	fixedregulator3v3: fixedregulator@0 {
> 
>    Ugh, this node should be named just "regulator@0". The label also doesn't
> appeal to me -- I'd rather prefer a name derived from the schematics. :-/

Please feel free to supply an incremental cleanup patch.
