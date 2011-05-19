From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Thu, 19 May 2011 01:18:02 +0000
Subject: Re: [PATCH 4/6 v2] sh_mobile_meram: MERAM platform data for LCDC
Message-Id: <4DD46FCA.50906@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1305717011-20742-5-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1305717011-20742-5-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 2011/05/19 9:42, Magnus Damm wrote:
> Hi Damian,
> 
> On Wed, May 18, 2011 at 8:10 PM, Damian Hobson-Garcia
> <dhobsong@igel.co.jp> wrote:
>> Based on the patch by Takanari Hayama <taki@igel.co.jp>
>>
>> Add the necessary platform data to add MERAM functionality to LCDC
>>
>> Includes platform data for both the AP4EVB and mackerel
>>
>> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
>> ---
>> Changed from V1
>> ==>> * Changed .id from -1 to 0 in platform data
>> * Added mackerel platform data
> 
> Thanks for your work on this!
> 
>>  arch/arm/mach-shmobile/board-ap4evb.c   |   73 ++++++++++++++++++++++++++++++
>>  arch/arm/mach-shmobile/board-mackerel.c |   74 +++++++++++++++++++++++++++++++
>>  2 files changed, 147 insertions(+), 0 deletions(-)
>>
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
>> +#ifdef CONFIG_FB_SH_MOBILE_MERAM
>> +#endif
> 
> Uhm, hate to interfer with your #ifdef party, but... =)
> 
> Could you please update the code to always define the platform data
> regardless of if CONFIG_FB_SH_MOBILE_MERAM is selected or not. That's
> the way we do it for almost all platform devices today.
Ok that's not a problem. I can rework that.
> 
> The exception is for some SDHI/MMC devices that can be driven from one
> out of multiple drivers. In such case we configure the pinmux /
> platform data depending on which drivers that are available.
> 
> Thanks,
> 
> / magnus


-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
