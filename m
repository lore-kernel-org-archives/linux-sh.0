From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 24 Jan 2015 23:16:34 +0000
Subject: Re: [PATCH 04/11] ARM: shmobile: r8a7778: common clock framework CPG driver
Message-Id: <7689709.OlM3GtWmty@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Friday 23 January 2015 18:00:02 Ulrich Hecht wrote:
> On Thu, Jan 22, 2015 at 12:37 AM, Laurent Pinchart wrote:
> >> +     if (!strcmp(name, "extal")) {
> >> +             return clk_register_fixed_rate(NULL, "extal", NULL,
> >> +                     CLK_IS_ROOT,
> >> r8a7778_rates[cpg_mode_rates].extal_rate);
> >
> > As the external clock is an input to the CPG, shouldn't it be specified by
> > a separate fixed-frequency clock DT node, and referenced by the CPG using
> > the clocks attributes ? You could then remove the extal_rate field from
> > the r8a7778_rates array above, and possibly rename the array to
> > r8a7778_pll_mults or similar.
> 
> This is a translation of what the legacy clock driver does.  These
> frequencies seem to be assumptions as to what input clocks would be
> reasonable given the current mode bits.  If I interpret the schematics
> correctly, the Bock-W board has a socketed oscillator, and the mode
> bits are switchable, so it's up to the user to configure the board to
> a sane setting.  To me, neither a fixed frequency nor this list of
> educated guesses seems quite "right" under these circumstances...

A separate fixed frequency clock DT matches the board configuration, so I 
think that's what should be used. It's true that the user could replace the 
oscillator, and in that case the DT will need to be updated. There's not much 
we can do for non-discoverable devices. Even if that solution isn't perfect, I 
think it's better than making the CPG node provide the external clock source, 
as it clearly doesn't from a hardware point of view.

-- 
Regards,

Laurent Pinchart

