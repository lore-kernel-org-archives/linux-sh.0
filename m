From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2015 04:10:05 +0000
Subject: Re: [PATCH v8 03/05] clk: shmobile: Add Renesas Module Standby and Reset driver
Message-Id: <CANqRtoRgzKKUi0WL=bPqp2B7K065Frco=S4WrYHD0a1dA7mVYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151001143717.20618.26365.sendpatchset@little-apple>
	<20151001143748.20618.7279.sendpatchset@little-apple>
	<CAMuHMdV=kKS+R4SFHrmZL5pntpdAP1tR1kRyKKsW0fD1nVrj1w@mail.gmail.com>
In-Reply-To: <CAMuHMdV=kKS+R4SFHrmZL5pntpdAP1tR1kRyKKsW0fD1nVrj1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Geert,

On Fri, Oct 2, 2015 at 12:28 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Thu, Oct 1, 2015 at 4:37 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Add a driver for the Renesas Module Standby and Software Reset module
>> found in several Renesas SoCs.
>>
>> This driver is based on the existing R-Car MSTP driver, and is intended
>> to replace it.
>> The existing driver is limited to Module Standby, and has bindings that
>> are difficult to extend to more register sets for e.g. reset control.
>>
>> TODO:
>>   - Implement module reset handling,
>>   - Write binding documentation.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Thanks, I'm happy you like it!

Yeah, it looks good!

I'm interested in learning how to tie in the reset functionality via
DT though, do we need any integration update for that?

>> ---
>>
>>  Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
>>  - New patch, took local v3 patch from Geert and removed r8a7791 references.
>
> You forgot one reference indicated below.

Oops, thanks for pointing that out!

>>  drivers/clk/shmobile/clk-mssr.c |  392 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/clk/shmobile.h    |    2
>>  2 files changed, 394 insertions(+)
>>
>> --- /dev/null
>> +++ work/drivers/clk/shmobile/clk-mssr.c        2015-10-01 18:38:50.320513000 +0900
>> @@ -0,0 +1,392 @@
>
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>> +static int cpg_mssr_attach_dev(struct generic_pm_domain *domain,
>> +                              struct device *dev)
>> +{
>> +       struct device_node *np = dev->of_node;
>> +       struct of_phandle_args clkspec;
>> +       struct clk *clk;
>> +       int i = 0;
>> +       int error;
>> +
>> +       while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
>> +                                          &clkspec)) {
>> +               if (of_device_is_compatible(clkspec.np,
>> +                                           "renesas,r8a7791-cpg-mssr"))
>
> renesas,r8a7795-cpg-mssr
>
> Else it won't manage the module clocks, and things may fail miserably.

Thanks, I've cooked up a fix based on your information and posted it as:
[PATCH] clk: shmobile: Fix r8a7795 MSSR support

Please include the fix in the topic branch. I will fold it in when
updating the series.

Cheers,

/ magnus
