From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 13 Feb 2014 17:43:19 +0000
Subject: Re: mstp10 clock bug
Message-Id: <52FD0437.5020400@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <52FBC50D.4000907@codethink.co.uk>
In-Reply-To: <52FBC50D.4000907@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 13/02/14 14:51, Laurent Pinchart wrote:
> Hi Ben,
>
> On Wednesday 12 February 2014 19:01:33 Ben Dooks wrote:
>> William and I have been looking at the clock bug on mstp10_clks
>> from the sound.git patch which reverts all the clocks [1]
>>
>> What happens is that when register the node:
>>> -		mstp10_clks: mstp10_clks@e6150998 {
>>> -			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-
> mstp-clocks";
>>> -			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
>>> -			clocks = <&p_clk>, <&mstp10_clks R8A7790_CLK_SSI>,
>>> -				 <&mstp10_clks R8A7790_CLK_SSI>, <&mstp10_clks
> R8A7790_CLK_SSI>,
>>> -				 <&mstp10_clks R8A7790_CLK_SSI>, <&mstp10_clks
> R8A7790_CLK_SSI>,
>>> -				 <&mstp10_clks R8A7790_CLK_SSI>, <&mstp10_clks
> R8A7790_CLK_SSI>,
>>> -				 <&mstp10_clks R8A7790_CLK_SSI>, <&mstp10_clks
> R8A7790_CLK_SSI>,
>>> -				 <&mstp10_clks R8A7790_CLK_SSI>;
>>> -			#clock-cells = <1>;
>>> -			renesas,clock-indices = <
>>> -				R8A7790_CLK_SSI R8A7790_CLK_SSI9 R8A7790_CLK_SSI8
>>> -				R8A7790_CLK_SSI7 R8A7790_CLK_SSI6 R8A7790_CLK_SSI5
>>> -				R8A7790_CLK_SSI4 R8A7790_CLK_SSI3 R8A7790_CLK_SSI2
>>> -				R8A7790_CLK_SSI1 R8A7790_CLK_SSI0
>>> -			>;
>>> -			clock-output-names >>> -				"ssi", "ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
>>> -				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0";
>>> -		};
>>>
>>>   	};
>>
>> The ssi5 clock is registered with a parent of ssi5, not ssi as described
>> in the above node.
>>
>> This is due to of_clk_get_parent_name() reading the clock-output-names
>> property and _assuming_ a 1:1 correspondence for the clock index to the
>> clock-output-names position. In the case of the mstp clocks each of
>> these nodes has sparse entries, which means the following:
>>
>> <&mstp10_clks R8A7790_CLK_SSI> R8A7790_CLK_SSI becomes <&mstp10_clks 5>
>> and the 5th entry in clock-output-names is "ssi5".
>>
>> This means that the entire machine comes to a halt as the clock layer
>> tries to create a clock with itself as a parent (never a good idea)
>>
>> Currently we do not know the best way to fix this.
>>
>> - we could update the of_clk_get_parent_name() to check the presence of
>>     renesas,clock-indices which would be a hack.
>>
>> - allow the clock driver to register a parent name callback, but that
>>     would assume we never looked up nodes that where not registered yet.
>>
>> - change all the clock-output-names arrays for rcar dtsi files to have
>>     null entries where needed, which would be not nice.
>>
>> - add a new property for mapping numbers to clock indicies and moving
>>     the renesas,clock-indices to use that (although that would still end
>>     up causing a number of issues with the clock handling as is)
>>
>>> https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=t
>>> opic/rcar&idp8d2aa14d1eefef3dd758242787e837485baad7
>
> I've submitted a second version of the SSI clocks patches that fixes the issue
> (http://www.spinics.net/lists/linux-sh/msg27013.html). I've just pinged Mike
> Turquette and have CC'ed you.
>
> As explained in the cover letter, the problem comes from the fact that the
> meaning of the DT "clocks" property depends on whether the property is located
> in a clock provider node or a clock consumer node. Let's discuss the issue in
> the other mail thread.

Ok, I've got a 2-3 patch series that fixes the problem by changing the
renesas,clock-indicies to clock-indicies and making the code looking
up the name use this to work out the array index of clock-output-names.





-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
