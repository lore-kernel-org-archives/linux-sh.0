From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 13 Mar 2009 15:09:10 +0000
Subject: Re: [PATCH v2] sh: Update dma-sh api
Message-Id: <20090313150909.GA21631@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B5D5E4.4060801@renesas.com>
In-Reply-To: <49B5D5E4.4060801@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 13, 2009 at 12:05:25PM +0000, Adrian McMenamin wrote:
> 2009/3/10 Paul Mundt <lethal@linux-sh.org>:
> > On Tue, Mar 10, 2009 at 04:22:37PM +0900, Nobuhiro Iwamatsu wrote:
> >> Paul Mundt wrote:
> >> >On Tue, Mar 10, 2009 at 01:48:14PM +0900, Nobuhiro Iwamatsu wrote:
> 
>  ...
> 
> >> I see.
> >> I have already been writing the driver of DMAengine, and I am testing.
> >> To make old DMA-API coexist with dma engine in these patches, I wrote.
> >>
> > Ah, ok, I wasn't aware that that was what your intention was. In that
> > case, once the Dreamcast fallout is fixed, I'll merge these.
> 
> 
> Just come across this. I am happy to test any new patch on the
> Dreamcast once it's done. Just let me know and kick me if I don't
> respond.

The updated version of this is merged now, so please see if there are any
regressions in the current git tree.
