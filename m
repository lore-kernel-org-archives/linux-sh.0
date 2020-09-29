From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Date: Tue, 29 Sep 2020 08:21:13 +0000
Subject: Re: [PATCH] sh: remove CONFIG_IDE from most defconfig
Message-Id: <0693c197-051b-2a37-208d-eb6c40e650db@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200924043139.522028-1-hch@lst.de>
In-Reply-To: <20200924043139.522028-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On 25.09.2020 11:30, Sergei Shtylyov wrote:

>> Remove CONFIG_IDE from defconfigs that did not actually select chipset
>> drivers, and switch ones that have libata drivers to libata.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [...]
>> diff --git a/arch/sh/configs/sdk7786_defconfig 
>> b/arch/sh/configs/sdk7786_defconfig
>> index 61bec46ebd66a8..4a44cac640bc94 100644
>> --- a/arch/sh/configs/sdk7786_defconfig
>> +++ b/arch/sh/configs/sdk7786_defconfig
>> @@ -116,9 +116,6 @@ CONFIG_MTD_UBI_GLUEBI=m
>>   CONFIG_BLK_DEV_LOOP=y
>>   CONFIG_BLK_DEV_CRYPTOLOOP=y
>>   CONFIG_BLK_DEV_RAM=y
>> -CONFIG_IDE=y
>> -CONFIG_BLK_DEV_IDECD=y
>> -CONFIG_BLK_DEV_PLATFORM=y
> 
>     How about CONFIG_PATA_PLATFORM=y here?

    Ah, it enables both IDE and PATA drivers! Sorry for the noise then. :-)

>>   CONFIG_BLK_DEV_SD=y
>>   CONFIG_BLK_DEV_SR=y
>>   CONFIG_SCSI_MULTI_LUN=y
> [...]

MBR, Sergei
