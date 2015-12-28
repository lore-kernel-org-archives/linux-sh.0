From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 28 Dec 2015 14:35:33 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: add DU DT support
Message-Id: <568148B5.6080202@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <2158897.lfmL4b1c4V@wasted.cogentembedded.com>
 <20151228052902.GF1066@verge.net.au>
In-Reply-To: <20151228052902.GF1066@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 12/28/2015 08:29 AM, Simon Horman wrote:

>> Define  the Porter board dependent part of the DU device node.
>> Add the device node  for Analog Devices ADV7511W  HDMI transmitter to I2C2
>> bus and the HDMI connector. Add the necessary subnodes to interconnect  DU
>> and HDMI devices.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against 'renesas-devel-20151221-v4.4-rc6' tag of Simon Horman's
>> 'renesas.git' repo.
>
> Thanks, I have queued this up for v4.6.

    Actually, I was going to check this patch WRT the DU channels used, given 
Laurent's remark. OK, I will just send an incremental patch if needed.

MBR, Sergei

