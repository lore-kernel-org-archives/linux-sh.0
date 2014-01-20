From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 10:58:30 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add i2c[0-3] clocks
Message-Id: <52DD0156.3030403@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389974082-27677-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389974082-27677-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20/01/14 10:55, Laurent Pinchart wrote:
> Hi Ben,
>
> On Monday 20 January 2014 10:51:28 Ben Dooks wrote:
>> On 19/01/14 11:03, Laurent Pinchart wrote:
>>> Hi Ben,
>>>
>>> Thank you for the patch.
>>>
>>> On Friday 17 January 2014 15:54:42 Ben Dooks wrote:
>>>> Add the necessary clocks for i2c0 to i2c3 into the mstp3 clock node. This
>>>> is a pre-cursor to adding the i2c devices themslves.
>>>
>>> According to the R8A7790 datasheet the I2C MSTP clocks are handled by
>>> MSTP9, not MSTP3, and they're already declared in the MSTP9 DT node.
>>
>> Ah, the i2cX nodes themselves are wrong.
>>
>>           i2c1: i2c@e6518000 {
>>                   #address-cells = <1>;
>>                   #size-cells = <0>;
>>                   compatible = "renesas,i2c-r8a7790";
>>                   reg = <0 0xe6518000 0 0x40>;
>>                   interrupt-parent = <&gic>;
>>                   interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
>>                   clocks = <&mstp3_clks R8A7790_CLK_I2C1>;
>>                   status = "disabled";
>>           };
>
> Indeed, my bad. Would you like to submit a patch to fix this, or should I do
> it ?

I am just finishing up a patch.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
