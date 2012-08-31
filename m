From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Fri, 31 Aug 2012 02:50:15 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: kzm9g: add r8a66597_udc support
Message-Id: <50402667.5080707@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2921A.2080803@kmckk.co.jp>
In-Reply-To: <4FF2921A.2080803@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul, Simon, Thank you for comments.
I will refine this patch using Kconfig option.

(2012/08/30 15:22), Paul Mundt wrote:
> (Resending due to mail server silliness, apologies for any duplicates)
>
> On Sat, Aug 25, 2012 at 11:01:10AM +0900, Simon Horman wrote:
>> On Tue, Jul 03, 2012 at 03:32:58PM +0900, Tetsuyuki Kobayashi wrote:
>>> Add r8a66597_udc support for CN6 connector on KZM-A9-GT board.
>>> r8a66597 USB controller can not use host mode and peripheral mode
>>> at the same time. At default r8a66597_udc is disabled.
>>> To use r8a66597_udc define USE_R8A66597_UDC.
>>>
>>> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>>> ---
>>> Hello,
>>>
>>> This is an experimental patch to test if r8a66597_udc works or not.
>>> I think that using r8a66597_udc is very rare because usually r8a66597_hcd is used
>>> and they can not use at the same time. So this patch is really for test and
>>> I add this patch code is all inside #ifdef USE_R8A66597_UDC.
>>>
>>> My question, this kind of test code should not merge to mainline?
>>> Or, the define USE_R8A66597_UDC should be change to CONFIG_R8A66597_UDC or so,
>>> and it to Kconfig?
>>
>> Hi Kobayashi-san,
>>
>> my opinion is that this kind of code should be merged into mainline and
>> that a run-time switch or or more likely Kconfig options should be in place
>> to ensure that hdc and udc can't run at the same time.
>>
>> Paul, do you have an opinion on this?
>>
> In general the ifdeffery for this should be avoided anyways, whether this
> means we need to register a dummy gpio or whatever else that can be
> consumed by both the udc/hcd drivers, ensuring that whoever gets there
> first succeeds in its probe path.
>
> If you need to put ifdefs in your platform device array, something is
> horribly wrong in the drivers. ie, there's nothing stopping you from
> having both built as modules, and you should have no problems switching
> from one to the other.
>

