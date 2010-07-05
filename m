From: Bill Traynor <wmat@naoi.ca>
Date: Mon, 05 Jul 2010 03:29:28 +0000
Subject: Re: upgrading u-boot from linux for SH7785LCR board
Message-Id: <4C315198.6040708@naoi.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <4C30CEC3.1050003@naoi.ca>
In-Reply-To: <4C30CEC3.1050003@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10-07-04 05:24 PM, Mike Frysinger wrote:
> On Sunday, July 04, 2010 14:11:15 Bill Traynor wrote:
>    
>> I've compiled and tested u-boot from git for the 7785lcr board.  I'd
>> like to write the u-boot.bin to flash but do not have a JTAG to be able
>> to recover if the write fails.
>>
>> Given the MTD layout:
>> dev:    size   erasesize  name
>> mtd0: 00080000 00040000 "loader"
>> mtd1: 00080000 00040000 "bootenv"
>> mtd2: 00400000 00040000 "kernel"
>> mtd3: 03b00000 00040000 "data"
>>
>> Is it reasonable to do the following:
>>
>> flash_erase /dev/mtd[0]
>> dd if=/tmp/u-boot.bin of=/dev/mtd0 bs8k conv=sync
>>      
> why dont you just use the mtdblock interface ?  it will take care of all the
> weird flash issues like erasing/etc...
>
> all i do is:
> cat u-boot.bin>  /dev/mtdblock0
>    
Thanks, that worked perfectly.

> -mike
>    

