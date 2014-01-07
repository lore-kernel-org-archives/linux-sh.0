From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 Jan 2014 23:06:39 +0000
Subject: Re: [PATCH 0/2] clk: shmobile rcar-gen2 fixes
Message-Id: <1591253.8BzYfubhGS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdUVGAL_h8iezPHZsmfC+77xXE9+irNywk4LYcqAMk9JGg@mail.gmail.com>
In-Reply-To: <CAMuHMdUVGAL_h8iezPHZsmfC+77xXE9+irNywk4LYcqAMk9JGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

On Tuesday 07 January 2014 17:59:01 Geert Uytterhoeven wrote:
> On Tue, Jan 7, 2014 at 5:47 PM, Laurent Pinchart wrote:
> > Geert, could you please verify that the series fixes your QSPI clock
> > issues with the Koelsch board ?
> > 
> > Laurent Pinchart (2):
> >   clk: shmobile: rcar-gen2: Fix clock parent all non-PLL clocks
> >   clk: shmobile: rcar-gen2: Fix qspi divisor
> 
> Thanks, both:
> 
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you.

Mike, could you please pick those patches up for v3.14 ?

-- 
Regards,

Laurent Pinchart

