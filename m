From: Simon Horman <horms@verge.net.au>
Date: Thu, 16 Oct 2014 05:16:57 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: Add clock to DT
Message-Id: <20141016051657.GD1265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1413270103-9517-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdXTD6dRAaQoNmm2y7AKWFDwLyt0hmr2q_tRUfbnevEEUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXTD6dRAaQoNmm2y7AKWFDwLyt0hmr2q_tRUfbnevEEUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 14, 2014 at 09:30:49PM +0200, Geert Uytterhoeven wrote:
> Hi Kaneko-san,
> 
> On Tue, Oct 14, 2014 at 9:01 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > This patch series is based on the renesas-devel-20141007-v3.17 tag
> > of Simon's renesas tree.
> >
> > Changes from v1:
> >  - change the clock name to "3dg" from "pvrsrvkm".
> >  - use the clock name "fdp1-2", "fdp1-1", "fdp1-0", instead of "fdp2",
> >    "fdp1" and "fdp0".
> >  - change the definition according to the clock name.
> 
> Thanks for this new version.
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks everyone,

I have queued these up for v3.19.
