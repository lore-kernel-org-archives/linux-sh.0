From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 18 Feb 2014 12:14:31 +0000
Subject: Re: [PATCH 2/3] renesas: change to using clock-indices
Message-Id: <3903064.2RRzHPyfcO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tuesday 18 February 2014 10:50:07 Magnus Damm wrote:
> On Sat, Feb 15, 2014 at 10:20 PM, Geert Uytterhoeven wrote:
> > On Fri, Feb 14, 2014 at 3:34 PM, Laurent Pinchart wrote:
> >>> >> Regarding how to roll it into the SoC code, I feel that this patch
> >>> >> [2/3] and next patch [3/3] potentially causes breakage with the
> >>> >> existing binding that was part of the v3.13 upstream kernel.
> >>> > 
> >>> > If I'm not mistaken that's v3.14, not v3.13.
> >>> 
> >>> Nope, it's merged in v3.13. Looked it up before sending the email. =)
> >> 
> >> I might be missing something, but
> >> 
> >> $ git log v3.13 --oneline -- drivers/clk/shmobile/ | wc
> >>       0       0       0
> >> $ git log v3.14-rc1 --oneline -- drivers/clk/shmobile/ | wc
> >>       6      48     309
> > 
> > It's the published bindings that count, right?
> 
> Good question. I don't know actually.
> 
> > Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > was added in commit f94859c215b6d977794108a1a9a101239e393c09
> > ("clk: shmobile: Add MSTP clock support").
> > 
> > $ git tag --contains f94859c215b6d977794108a1a9a101239e393c09
> > v3.14-rc1
> > v3.14-rc2
> > $
> > 
> > Now, the bindings must be in flux, as the documentation doesn't match
> > the code, nor the example:
> > 
> > Documentation says:
> > 
> > +  - renesas,indices: Indices of the gate clocks into the group (0 to 31)
> > 
> > Example and implementation use "renesas,clock-indices":
> >                 renesas,clock-indices = <
> >                         R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1
> >                         R8A7790_CLK_SDHI3
> >                         R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1
> >                         R8A7790_CLK_SDHI0
> >                         R8A7790_CLK_MMCIF0
> >                 >;
> > 
> > Woops...
> 
> Thanks for spotting this. I believe Laurent will fix this up in the not so
> distant future.

I plan to wait for Mike to comment on Ben's patches before addressing this.

-- 
Regards,

Laurent Pinchart

