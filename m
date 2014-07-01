From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 01 Jul 2014 18:55:42 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791: add CAN pin groups
Message-Id: <53B3042E.1060606@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407010211.23665.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407010211.23665.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 07/01/2014 11:11 AM, Laurent Pinchart wrote:

>> Add CAN0/1 data/clock pin groups to R8A7791 PFC driver.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
>> repo.

>>   drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  153 +++++++++++++++++++++++++++++++
>>   1 file changed, 153 insertions(+)

>> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
>> =================================>> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
>> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
>> @@ -1726,6 +1726,119 @@ static const unsigned int audio_clkout_m
>>   	AUDIO_CLKOUT_MARK,
>>   };
>>
>> +/* - CAN --------------------------------------------------------------- */

> [snip]

>> +static const unsigned int can_clk_c_pins[] = {
>> +	RCAR_GP_PIN(4, 31),

> Shouldn't this be (4, 30) ?

    Indeed, thank you for checking!

WBR, Sergei

