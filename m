From: Tung Pham <tungps@gcs-vn.com>
Date: Wed, 17 Oct 2012 05:01:18 +0000
Subject: Re: SH kernel boot up issue
Message-Id: <507E3B9E.9070701@gcs-vn.com>
List-Id: <linux-sh.vger.kernel.org>
References: <507D5FD5.4050501@gcs-vn.com>
In-Reply-To: <507D5FD5.4050501@gcs-vn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Mike,

I'm working on custom board that uses sh-7710 cpu, and I tried to boot
with kernel version 2.6.35.13.

Do you have any idea for this?
BTW: last kernel worked : 2.6.15

Thanks,
-Tung

On 10/17/2012 10:50 AM, Mike Frysinger wrote:
> On Tuesday 16 October 2012 09:23:33 Tung Pham wrote:
>> I have an old working kernel for my SH board and now I'm trying
>> to move it to a newer version. The approach is to merge some
>> patches of old kernel to new one.
>> 
>> Currently I have an issue with boot up new board. The board can
>> be boot up successfully but after awhile the board reboot
>> automatically. There's nothing inside the dmesg and syslog. I
>> tried to add printk in some suspend/shutdown function but nothing
>> logged out.
>> 
>> Do you have any idea to fix this issue?
> 
> what board/CPU are you using exactly ?
> 
> what was the last kernel version that worked ? -mike

