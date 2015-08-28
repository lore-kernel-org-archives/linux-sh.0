From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 28 Aug 2015 09:21:06 +0000
Subject: Re: [PATCH v3 04/04] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
Message-Id: <CANqRtoThE+coDOW1TG7cLc1sLBtOz46y=End-RGwdtbEu_5zJA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150828091550.21731.85227.sendpatchset@little-apple>
	<20150828091636.21731.26416.sendpatchset@little-apple>
	<CAMuHMdWdmbHyv5YnFKh=ixMjPJGGyhSFyo5GqBs3S9L1H+iERQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWdmbHyv5YnFKh=ixMjPJGGyhSFyo5GqBs3S9L1H+iERQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Geert,

On Fri, Aug 28, 2015 at 6:19 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Aug 28, 2015 at 11:16 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Shmobile is all multiplatform these days, so get rid of the
>> reference to CONFIG_ARCH_SHMOBILE_MULTI. Also instead of always
>> enabling DIV6 and MSTP adjust the Makefile to enable DIV6 and
>> MSTP depending on if they are included in the SoC or not.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>
>>  Changes since V2:
>>  - Fixed patch subject typo CONFIG_SHMOBILE_MULTI -> CONFIG_ARCH_SHMOBILE_MULTI
>
> The subject doesn't seem to match the patch at all?

Yes, correct - I seem to have messed up something! Will fix.

Thanks,

/ magnus
