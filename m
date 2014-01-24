From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 20:43:31 +0000
Subject: Re: [PATCH V2 3/3] ARM: shmobile: lager: Add internal PCI support
Message-Id: <52E2D073.4000704@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982854-20680-4-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389982854-20680-4-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/24/2014 08:51 AM, Magnus Damm wrote:
> On Sat, Jan 18, 2014 at 3:20 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
>> This adds internal PCI USB host devices to R-Car H2 Lager board.
>> If USBHS device is disabled, channel 0 is configured as PCI USB host.
>> Otherwise, it is configured as USBHS. The USB phy is bound bound to
>> either USB host or USBHS device respectively. We don't bind USB phy
>> to the PCI host at channel 2 since it's configured as PCI host by
>> default and is not currently used by anything else.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   arch/arm/mach-shmobile/board-lager.c | 90 +++++++++++++++++++++++++++++++-----
>>   1 file changed, 79 insertions(+), 11 deletions(-)
>>
>> Changes in V2:
>> * capitalized ARM in the subject;
>> * rebased on top the latest devel tag.
>
> Hi Valentine,
>
> This patch needs more work before it is ready for merge. So lets wait
> and focus on USBHS - for instance the Runtime PM bits need to work
> too.

Runtime PM seems to work fine for me. I did not change lager_defconfig
and have CONFIG_PM_RUNTIME=y

>
>> @@ -537,8 +604,14 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
>>          PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-vin.1", "pfc-r8a7790",
>>                                    "vin1_clk", "vin1"),
>>          /* USB0 */
>> -       PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
>> +       PIN_MAP_MUX_GROUP_DEFAULT(LAGER_USB0_NAME, "pfc-r8a7790",
>>                                    "usb0", "usb0"),
>> +       /* USB1 */
>> +       PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
>> +                                 "usb1", "usb1"),
>> +       /* USB2 */
>> +       PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
>> +                                 "usb2", "usb2"),
>>   };
>
> I don't think "renesas_usbhs" is correct in this case.

Indeed, the copy/paste error crawled in after several rebasings.

I'll repost the hole series with your ack's added to the first patches
and this patch fixed.

>
> Cheers,
>
> / magnus
>

Thanks,
Val.
