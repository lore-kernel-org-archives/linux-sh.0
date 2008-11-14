From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 14 Nov 2008 06:26:24 +0000
Subject: Re: smsc911x in 2.6.29
Message-Id: <491D1A10.8080102@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OF18129353.0F9B8038-ON802574F9.003C4672-802574F9.003D1A48@smsc.com>
In-Reply-To: <OF18129353.0F9B8038-ON802574F9.003C4672-802574F9.003D1A48@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Steve.

I checked your patch on ap325rxa board.
Your patch had compile error. I fixed this.
When fixed this patch, this board work fine.

Rsk7203 has hardware problem. It doesn't yet work.
It may take time.

I will send patch about ap325rxa, magicpanelr2 and rsk7203.

Best regards,
  Nobuhiro

Nobuhiro Iwamatsu wrote:
> Hi, Steve.
> 
> 2008/11/6  <Steve.Glendinning@smsc.com>:
>> Hi all,
>>
>> I recently posted a patchset on netdev to replace smc911x with a new
>> vendor-supported smsc911x driver:
>>
>>    http://marc.info/?l=linux-netdev&m2588138425309&w=4
>>
>> Jeff Garzik has merged the driver itself for net-next (2.6.29).
>>
>> 3 of the patches convert sh platforms (rsk7203, ap325rxa & magicpanelr2)
>> from one driver to the other, but I don't have access to any of these
>> platforms to test.  Can anyone here help?
>>
>> Please let me know if anyone wants me to re-send them the whole patchset
>> (6 patches).
> 
> OK,  I will test and report about rsk7203 and ap325rxa.


