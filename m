From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Apr 2010 07:09:02 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <s2yaec7e5c31004220009o10291d15n619c1ddacca9499@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 22, 2010 at 3:22 PM, Alexandre Courbot
<alex@dcl.info.waseda.ac.jp> wrote:
>>> We are also trying to get the latest Linux to run on the SH2007
>>> platform, and since the new serial driver boot fails during SCIF
>>> intialization. I have attached a boot log of what is sent to the
>>> serial line. The output gets cut right in the middle of displaying
>>> status for sh-sci.1. Any clue on that issue would be greatly
>>> appreciated.
>>
>> Is the SH2007 board based on sh7780? Perhaps it's a clock issue.
>
> It's a 7780 indeed. I'm not a specialist of the SH platform (still
> learning), but I'll try to look at this from a clock perspective. FYI,
> the early printk is done through the bios.

Does the kernel commandline option "earlyprintk=sh-sci.1,115200" work?

/ magnus
