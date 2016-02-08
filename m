From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 08 Feb 2016 13:54:50 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7791: add MSTP10 support on DTSI
Message-Id: <56B89E2A.3050309@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387998730-6012-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387998730-6012-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/08/2016 03:39 AM, Kuninori Morimoto wrote:

>>> +		mstp10_clks: mstp10_clks@e6150998 {
>>> +			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
>>> +			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
>>> +			clocks = <&p_clk>,
>>> +				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
>>> +				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
>>
>>     But don't SSI[0-9] clocks all depend on SSI(all)? Shouldn't the
>> above 10 entries be
>> <&mstp10_clks R8A7791_CLK_SSI_ALL> like it was done to SCU(all)?
>
> Basically, you are correct.
> I forgot detail, but SSI(all) will be enabled by normal pm_runtime_xxx().
> And it had clock enable order dependency before.
> (I think it was solved by using clock-indices feature)

    Not sure I understand.

> It is not very correct indeed, but basically no problem I think.
> But do you have some issues ?

    Just was looking at the manual writing the R8A7794 device tree audio 
support and this inconsistency came up.

MBR, Sergei

