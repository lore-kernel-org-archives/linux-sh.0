From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 02 Aug 2013 13:18:12 +0000
Subject: Re: [PATCH 1/3 v3] ARM: shmobile: r8a7778: add usb phy power control function
Message-Id: <51FBB194.5080402@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/08/13 13:17, Sergei Shtylyov wrote:
> Hello.
>
> On 02-08-2013 5:02, Kuninori Morimoto wrote:
>
>> USB phy initialisation function is needed from not only
>> USB Host but also USB Function too.
>> This patch adds usb phy common control function.
>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> [...]
>
>> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c
>> b/arch/arm/mach-shmobile/setup-r8a7778.c
>> index 1a154d4..b65044a 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
>> @@ -95,29 +95,46 @@ static struct sh_timer_config
>> sh_tmu1_platform_data __initdata = {
>> &sh_tmu##idx##_platform_data, \
>> sizeof(sh_tmu##idx##_platform_data))
>>
>> -/* USB */
>> -static struct usb_phy *phy;
>> +int r8a7778_usb_phy_power(bool enable)
>> +{
>> + static struct usb_phy *phy = NULL;
>> + int ret = 0;
>> +
>> + if (!phy)
>> + phy = usb_get_phy(USB_PHY_TYPE_USB2);
>> +
>> + if (IS_ERR(phy)) {
>> + pr_err("it doesn't have usb phy driver\n");
>
> I would still like this message corrected.

Yes, something like "cannot get usb2 phy driver"

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
