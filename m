From: Simon Horman <horms@verge.net.au>
Date: Mon, 10 Aug 2015 23:20:58 +0000
Subject: Re: [PATCH v3 2/2] ARM: shmobile: r8a7794: add GPIO DT support
Message-Id: <20150810232054.GA9484@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <2265315.MpjeDzrVz2@wasted.cogentembedded.com>
 <10288801.ZnYt2TD47O@wasted.cogentembedded.com>
 <CAMuHMdVj4_h8LX=XuWSyhGpSZ2BPxuWe_oJQYTRPFfYbuidm4g@mail.gmail.com>
In-Reply-To: <CAMuHMdVj4_h8LX=XuWSyhGpSZ2BPxuWe_oJQYTRPFfYbuidm4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 10, 2015 at 03:23:54PM +0200, Geert Uytterhoeven wrote:
> Hi Sergei,
> 
> On Sun, Aug 9, 2015 at 12:09 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Describe GPIO[0-6] controllers in the R8A7794 device tree.
> >
> > Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
> >
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > ---
> > Changes in version 3:
> > - added "power-domains" property to the GPIO device nodes.
> 
> Thanks, unwithdrawing my ack ;-)
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued these up for v4.4.
