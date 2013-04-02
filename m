From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 02 Apr 2013 11:45:12 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
Message-Id: <515AC4C8.1080803@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
 <87y5d16b1d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5d16b1d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 02-04-2013 4:17, Kuninori Morimoto wrote:

>> +void __init r8a7779_add_ether_device(void *pdata)
>> +{
>> +	ether_device.dev.platform_data = pdata;
>> +
>> +	platform_device_register(&ether_device);
>> +}

> Current ARM SoC is trying to not use platform_device_register()
> Please use platform_device_register_xxx()
> Same comment for [2/2]

    Is there some rationale to it? I don't find platform_device_register_xxx()
especially handy to use.

WBR, Sergei

