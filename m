From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 02 Sep 2015 11:23:46 +0000
Subject: Re: [PATCH v6 03/05] clk: shmobile: Make MSTP clock-output-names optional
Message-Id: <55E6DC42.6080201@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150902071657.10870.37652.sendpatchset@little-apple>
 <20150902071728.10870.32730.sendpatchset@little-apple>
In-Reply-To: <20150902071728.10870.32730.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, mturquette@baylibre.com, gaku.inami.xw@bp.renesas.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com

Hello.

On 9/2/2015 10:17 AM, Magnus Damm wrote:

> From: Magnus Damm <damm+renesas@opensource.se>
>
> This patch updates the MSTP driver to make the "clock-output-names"
> DT property optional instead of mandatory. In case the DT property
> is omitted then the function clk_register_clkdev() is skipped.
>
> The default for new SoCs is to not use "clock-output-names".
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>   Changes since V5:
>   - Simplified code using const char *allocated_name - thanks Geert!
>
>   Changes since V4:
>   - None
>
>   Changes since V3:
>   - Added support for multiple MSTP bits. =)
>
>   drivers/clk/shmobile/clk-mstp.c |   24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
>
> --- 0001/drivers/clk/shmobile/clk-mstp.c
> +++ work/drivers/clk/shmobile/clk-mstp.c	2015-09-02 11:52:02.182366518 +0900
> @@ -193,26 +193,26 @@ static void __init cpg_mstp_clocks_init(
[...]
>   		parent_name = of_clk_get_parent_name(np, i);
>   		ret = of_property_read_u32_index(np, idxname, i, &clkidx);
>   		if (parent_name = NULL || ret < 0)
>   			break;
>
>   		if (clkidx >= MSTP_MAX_CLOCKS) {
> -			pr_err("%s: invalid clock %s %s index %u)\n",
> -			       __func__, np->name, name, clkidx);
> +			pr_err("%s: invalid clock %s index %u)\n",
> +			       __func__, np->name, clkidx);
>   			continue;
>   		}
>
> +		if (of_property_read_string_index(np, "clock-output-names",
> +						  i, &name) < 0)
> +			allocated_name = name = kasprintf(GFP_KERNEL, "%s.%u",
> +							   np->name, clkidx);

    There's too many spaces on this line, it's a bit over-indented.

[...]

MBR, Sergei

