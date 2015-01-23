From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 23 Jan 2015 17:00:02 +0000
Subject: Re: [PATCH 04/11] ARM: shmobile: r8a7778: common clock framework CPG driver
Message-Id: <CAO3366z7oXJ2eCQqqK1zUBc_-GpO8yA6hGpX5NBg4_WQg+UH2g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 22, 2015 at 12:37 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +     if (!strcmp(name, "extal")) {
>> +             return clk_register_fixed_rate(NULL, "extal", NULL,
>> +                     CLK_IS_ROOT, r8a7778_rates[cpg_mode_rates].extal_rate);
>
> As the external clock is an input to the CPG, shouldn't it be specified by a
> separate fixed-frequency clock DT node, and referenced by the CPG using the
> clocks attributes ? You could then remove the extal_rate field from the
> r8a7778_rates array above, and possibly rename the array to r8a7778_pll_mults
> or similar.
>

This is a translation of what the legacy clock driver does.  These
frequencies seem to be assumptions as to what input clocks would be
reasonable given the current mode bits.  If I interpret the schematics
correctly, the Bock-W board has a socketed oscillator, and the mode
bits are switchable, so it's up to the user to configure the board to
a sane setting.  To me, neither a fixed frequency nor this list of
educated guesses seems quite "right" under these circumstances...

CU
Uli
