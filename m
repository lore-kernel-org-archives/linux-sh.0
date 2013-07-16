From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 16 Jul 2013 14:26:23 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Fix ethernet device name in clock definition
Message-Id: <51E5580F.8030100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 07/16/2013 04:27 PM, Sergei Shtylyov wrote:

>> The ethernet device is named r8a7740-gether, fix the clock definition
>> accordingly.

>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> ---
>>   arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)

>> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c
>> b/arch/arm/mach-shmobile/clock-r8a7740.c
>> index de10fd7..e1e8710 100644
>> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
>> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
>> @@ -595,7 +595,7 @@ static struct clk_lookup lookups[] = {
>>       CLKDEV_DEV_ID("sh_mmcif",        &mstp_clks[MSTP312]),
>>       CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
>>       CLKDEV_DEV_ID("r8a7740-gether",        &mstp_clks[MSTP309]),
>> -    CLKDEV_DEV_ID("e9a00000.sh-eth",    &mstp_clks[MSTP309]),
>> +    CLKDEV_DEV_ID("e9a00000.r8a7740-gether", &mstp_clks[MSTP309]),

>     Al Ethernet devices should be named "ethernet", according to ePAPR spec.

    BTW, I'm not seeing a patch to r8a7740.dtsi, describing this device.

WBR, Sergei

