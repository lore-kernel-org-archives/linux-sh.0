From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Mon, 25 Jan 2016 09:08:20 +0000
Subject: Re: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <56A5E604.2020409@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 25.01.2016 09:51, Yoshihiro Shimoda wrote:
>> From: Dirk Behme
>> Sent: Friday, January 22, 2016 8:31 PM
>>
>> On 22.01.2016 11:32, Yoshihiro Shimoda wrote:
>>> Hi Dirk-san, Wolfram-san,
>>>
>>>>> And third, from reading the r8a7795 manual I think the manual talks about
>>>>>
>>>>> https://github.com/dirkbehme/linux-renesas-rcar-gen3/commit/f2a727c859916d59dca85dbb72c1b61da3fd6da0
>>>>>
>>>>> But testing this it doesn't work. So either the manual is wrong, or I missed
>>>>> anything else.
>>>>
>>>> I have seen this patch and my gut feeling is that it won't make a
>>>> difference? SCLKDIVEN is like CBUSY plus some more cycles AFAIU. But I
>>>> am not working on DMA issues now, this has to wait.
>>>
>>> I'm not sure we have to use CBSY bit instead of SCLKDIVEN on r8a7795.
>>
>>
>> The r8a7795 manual I have has several
>>
>> "Do / Do not xxx when the CBSY bit in SD_INFO2 is set to x"
>>
>> It always talks about CBSY, not SCLKDIVEN.
>
> Thank you for the detail. I agree with you about r8a7795.
> However, on previous SoC, it doesn't have CBSY bit.
> So, I guess we have to keep compatible for previous SoC somehow.


Yes, ack.

I've been thinking about implementing a "delay callback", which waits 
for bit 13 on previous SoCs and for bit 14 for r8a7795.

But I haven't looked into the details, yet. Maybe there is an easier 
solution.

Best regards

Dirk
