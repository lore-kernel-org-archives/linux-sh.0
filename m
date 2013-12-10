From: Valentine <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 11:45:12 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: pfc-r8a7790: Add full VIN1/2/3 support
Message-Id: <52A6FEC8.5060409@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1382040403-19649-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1382040403-19649-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/10/2013 05:45 AM, Laurent Pinchart wrote:
> Hi Valentine,
>
> On Monday 09 December 2013 23:14:29 Valentine wrote:
>> On 10/29/2013 10:10 PM, Laurent Pinchart wrote:
>>> On Friday 18 October 2013 00:06:43 Valentine Barshak wrote:
>>>> This adds missing VIN1/2/3 pin configuration to pfc-r8a7790.
>>>>
>>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>>> ---
>>>>
>>>>    drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 202 +++++++++++++++++++++++++++-
>>>>    1 file changed, 198 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
>>>> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 64fcc006..9ab2f71 100644
>>>> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
>>>> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
>>>> @@ -2996,22 +2996,168 @@ static const unsigned int vin0_clk_mux[] = {
>>>>    	VI0_CLK_MARK,
>>>>    };
>>>>    /* - VIN1 ---------------------------------------------------------- */
>>>> -static const unsigned int vin1_data_pins[] = {
>>>> +static const unsigned int vin1_data_g_pins[] = {
>>>> +	RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 17),
>>>> +	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 12),
>>>> +	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 7),
>>>> +};
>>>> +static const unsigned int vin1_data_g_mux[] = {
>>>> +	VI1_G0_MARK, VI1_G1_MARK, VI1_G2_MARK,
>>>> +	VI1_G3_MARK, VI1_G4_MARK, VI1_G5_MARK,
>>>> +	VI1_G6_MARK, VI1_G7_MARK,
>>>> +};
>>>> +static const unsigned int vin1_data_r_pins[] = {
>>>> +	RCAR_GP_PIN(0, 27), RCAR_GP_PIN(0, 28), RCAR_GP_PIN(0, 29),
>>>> +	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
>>>> +	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 8),
>>>> +};
>>>> +static const unsigned int vin1_data_r_mux[] = {
>>>> +	VI1_R0_MARK, VI1_R1_MARK, VI1_R2_MARK,
>>>> +	VI1_R3_MARK, VI1_R4_MARK, VI1_R5_MARK,
>>>> +	VI1_R6_MARK, VI1_R7_MARK,
>>>> +};
>>>> +static const unsigned int vin1_data_b_pins[] = {
>>>>    	RCAR_GP_PIN(2, 10), RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 12),
>>>>    	RCAR_GP_PIN(2, 13), RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 15),
>>>>    	RCAR_GP_PIN(2, 16), RCAR_GP_PIN(2, 17),
>>>>    };
>>>>
>>>> -static const unsigned int vin1_data_mux[] = {
>>>> +static const unsigned int vin1_data_b_mux[] = {
>>>>
>>>>    	VI1_DATA0_VI1_B0_MARK, VI1_DATA1_VI1_B1_MARK, VI1_DATA2_VI1_B2_MARK,
>>>>    	VI1_DATA3_VI1_B3_MARK, VI1_DATA4_VI1_B4_MARK, VI1_DATA5_VI1_B5_MARK,
>>>>    	VI1_DATA6_VI1_B6_MARK, VI1_DATA7_VI1_B7_MARK,
>>>>
>>>>    };
>>>
>>> Given the wide variety of ways the VIN data pins can be used, I see two
>>> ways to group them:
>>>
>>> - List all possible combinations of data pins with a single group per
>>> configuration. There are 11 combinations, but due to overlap in the pins
>>> used the number can be reduced to 8.
>>>
>>> - List groups individually and combine them to create a valid
>>> configuration. We would have at least 8 groups in this case as well.
>>>
>>> Given that the number of groups would be identical, my preference would go
>>> for the first solution. The RGB data pin group would contain all 24 RGB
>>> pins in that case, and additional overlapping groups would be defined for
>>> other input configurations. Would you be fine with that ? VIN1 would be
>>> handled identically, and VIN2 would need 5 groups only. VIN3 is already
>>> defined correctly, as it supports a single configuration only.
>>
>> I'm only adding missing stuff here. VIN0/VIN1 are identical so I'm adding
>> VIN1 the same way VIN0 is currently grouped.
>> I'm generally fine with re-grouping data pins, but I think it should be a
>> separate change. We'd also need to choose simple names for the groups which
>> are easily readable and show which pins are used there. Something like:
>> data_r07g07b07 (24 bits for RGB24)
>> data_r27g27b27 (pins 2-7 for ITU-R BT.601/BT.709 RGB-666)
>
> Renaming pin groups can be an issue if they are used by existing platforms, so
> I'd rather first think about the way pins should be grouped, fix the existing
> code if needed, and then adding the new groups. Would that be fine ?
>
>>>> +static const unsigned int vin1_hsync_signal_pins[] = {
>>>
>>> I think you can drop _signal here and below.
>>
>> I didn't intend to edit the existing naming. All I wanted to do is add the
>> definitions for the missing pins here. I think name editing should be done
>> by a separate patch if needed. IMHO, otherwise it would be a mess.
>>
>>>> +	RCAR_GP_PIN(1, 24),
>>>> +};
>>>> +static const unsigned int vin1_hsync_signal_mux[] = {
>>>> +	VI1_HSYNC_N_MARK,
>>>> +};
>>>> +static const unsigned int vin1_vsync_signal_pins[] = {
>>>> +	RCAR_GP_PIN(1, 25),
>>>> +};
>>>> +static const unsigned int vin1_vsync_signal_mux[] = {
>>>> +	VI1_VSYNC_N_MARK,
>>>> +};
>>>
>>> If I'm not mistaken the hsync and vsync signals can't be used
>>> independently, so they should be grouped together.
>>
>> I'm just using the current VIN0 layout for VIN1 here.
>> I'm not intending to regroup anything here. The purpose of these
>> changes is to add missing pins. I believe regrouping should be done
>> by a separate patch if needed.
>
> Sure, but could you then please send patches that drop _signal and group
> hsync+vsync, and rebase this patch on top of that ?
>

OK, I'll take a look at that, but I don't see much of a point in adjusting the names
and modifying/rebasing this patch on top of that.
I think that would just involve more work, while eventually having the same result.
I was planning to regroup the pins and rename the groups on top of this one.

Thanks,
Val.
