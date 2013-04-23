From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 23 Apr 2013 03:26:19 +0000
Subject: Re: [PATCH v2 2/5] sh-pfc: r8a7778: add VIN pin groups
Message-Id: <5175FF5B.1010703@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304212240.51203.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304212240.51203.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/23/2013 06:02 AM, Simon Horman wrote:

>
>> Hi,
>>
>> Thanks for the patch.
>>
>> On Sunday 21 April 2013 22:40:50 Sergei Shtylyov wrote:
>>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>
>>> Add VIN DATA[0:8]/CLK/HSYNC/VSYNC pin groups to R8A7778 PFC driver.
>>>
>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> [Sergei: updated the copyrights.]
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>> ---
>>>   drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   74 +++++++++++++++++++++++++++++++
>>>   1 file changed, 74 insertions(+)
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> -- 
>> Regards,
>>
>> Laurent Pinchart
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> On Mon, Apr 22, 2013 at 11:29:20PM +0200, Linus Walleij wrote:
>> On Sun, Apr 21, 2013 at 8:40 PM, Sergei Shtylyov
>> <sergei.shtylyov@cogentembedded.com> wrote:
>>
>>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>
>>> Add VIN DATA[0:8]/CLK/HSYNC/VSYNC pin groups to R8A7778 PFC driver.
>>>
>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> [Sergei: updated the copyrights.]
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Yours,
>> Linus Walleij
> Hi Sergei,
>
> If you were to rebase this patch I believe it could now
> be queued-up for v3.11.

     I've already rebased it to the tag 'renesas-next-20130422' and
shall probably post it RSN, all due my insomnia. :-)

WBR, Sergei

