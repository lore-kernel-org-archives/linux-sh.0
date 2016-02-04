From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Date: Thu, 04 Feb 2016 00:23:51 +0000
Subject: Re: [LTSI-dev] THERMAL:Incorrect measured temperature value after unbind/bind
Message-Id: <56B29A17.3030102@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20160203041020.GA22555@kroah.com>
In-Reply-To: <20160203041020.GA22555@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Grep

Thanhk for your reply.

I have seen the consultation of you and Mr.munakara.
I have understanded your thought.

Best regard,
Nguyen Viet Dung

On 2016年02月03日 13:10, Greg KH wrote:
> On Wed, Feb 03, 2016 at 09:55:09AM +0900, Nguyen Viet Dung wrote:
>> Hi,
>>
>> when testting LTSI-v4.1.13-rc1 on the SOC of RENESAS(Lager board, Koelsch
>> board),
>> we have found the following the failure about the rcar_thermal driver.
>> Detail of this failure is:
>> [After unbind/rebind rcar_thermal measured temperature is not
>> correct(-65.0°C)]
>> error log:
>>   Koelsch_Thermal_unbind_rebind_error_log.txt
>>   Lager_Thermal_unbind_rebind_error_log.txt
>>
>> We have checked that this failure had fixed by one Patch of Linux-Next
>> branch.
>> (5de85b9d57aba3ed2e04759e6db3b9e826dd0b06
>> "PM / runtime: Re-init runtime PM states at probe error and driver unbind")
>>
>> Please consider this patch to fix error for next LTSI release
> I'm a bit worried that something like this isn't in the stable
> kernel releases, shouldn't it also go there as well?
>
> thanks,
>
> greg k-h
>

